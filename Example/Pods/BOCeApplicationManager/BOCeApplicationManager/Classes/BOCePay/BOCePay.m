//
//  BOCePay.m
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCePay.h"
#import "WXApi.h"

@implementation BOCePay

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    [WXApi registerApp:@"wx99f8cb0bff31b996" universalLink:@"https://bocep2c.boce.cn/"];
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([url.host isEqualToString:@"pay"]) {   //微信支付
        return  [WXApi handleOpenURL:url delegate:[WXService shareWXService]];
    }else if ([url.host isEqualToString:@"safepay"]){//支付宝支付
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else if ([url.host isEqualToString:@"oauth"]){//微信登录
        
    }
    return  YES;
}



@end
