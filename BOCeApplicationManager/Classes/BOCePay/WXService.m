//
//  WXService.m
//  Industrial
//
//  Created by boce on 2019/9/3.
//  Copyright © 2019 boce. All rights reserved.
//

#import "WXService.h"
#import "WXModel.h"

@interface WXService ()

@end

@implementation WXService

+(instancetype)shareWXService{
    static dispatch_once_t onceToken;
    static WXService *serc=nil;
    dispatch_once(&onceToken, ^{
        serc=[[WXService alloc]init];
    });
    return serc;
}

-(void)setOrderID:(NSString *)orderID{
    _orderID=orderID;
    [self OrderWXPay];
}

-(void)OrderWXPay{
    [[BOCeNetManager shareManager] sendRequestWithRequest:^BOCeNetRequest * _Nonnull(BOCeNetRequest * _Nonnull request) {
        request.method=BOCEPOST;
        request.url=@"/weixin/unifiedOrder";
        request.parameters=@{@"orderId":self.orderID};
        return request;
    } complete:^(BOCeNetResponse * _Nonnull response) {
        if (response.status==BOCeNetStatusSuccess){
            PayReq *pay=[[PayReq alloc]init];
            pay.partnerId=[response.content objectForKey:@"partnerId"];
            pay.prepayId=[response.content objectForKey:@"prepayId"];
            pay.nonceStr=[response.content objectForKey:@"nonceStr"];
            NSString *number=[response.content objectForKey:@"timeStamp"];
            int timeStamp=[number intValue];
            pay.timeStamp=(UInt32)timeStamp;
            pay.package=[response.content objectForKey:@"package"];
            pay.sign=[response.content objectForKey:@"sign"];
            [WXApi sendReq:pay completion:nil];
        }else{
            if (self.block) {
               if (self.block) {
                   self.block(response.error);
                }
            }
        }
    }];
}

-(void)onResp:(BaseResp *)resp{
    switch (resp.errCode) {
        case WXSuccess:
            [self OrderPayState];
            break;
        default:
        {
            if (self.block) {
                self.block([NSError errorWithDomain:NSCocoaErrorDomain code:1230 userInfo:@{NSLocalizedDescriptionKey:resp.errStr==nil?@"用户退出":resp.errStr}]);
            }
        }
            break;
    }
}

-(void)OrderPayState{
    [[BOCeNetManager shareManager] sendRequestWithRequest:^BOCeNetRequest * _Nonnull(BOCeNetRequest * _Nonnull request) {
        request.method=BOCEGET;
        request.url=[NSString stringWithFormat:@"/weixin/queryOrder/%@",self.orderID];
        request.parameters=@{};
        return request;
    } complete:^(BOCeNetResponse * _Nonnull response){
        if (response.status==BOCeNetStatusSuccess){
            if (self.block){
                self.block(nil);
            }
        }else{
            if (self.block) {
                self.block(response.error);
            }
        }
    }];
}

@end
