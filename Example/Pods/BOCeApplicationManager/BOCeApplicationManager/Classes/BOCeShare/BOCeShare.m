//
//  BOCeShare.m
//  BoceGlobal
//
//  Created by boce on 2019/10/10.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeShare.h"

@implementation BOCeShare

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    //启动优化、一秒后调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
            //微信
            [platformsRegister setupWeChatWithAppId:@"wx99f8cb0bff31b996" appSecret:@"2c8ebf34fc4d94caeb350b2133c8291e" universalLink:@"https://bocep2c.boce.cn/"];
            //QQ
            [platformsRegister setupQQWithAppId:@"1108003192" appkey:@"jBvA4G9TInn4FoE9" enableUniversalLink:NO universalLink:nil];
            //新浪微博
            [platformsRegister setupSinaWeiboWithAppkey:@"2424076479" appSecret:@"9b181572cd40cc46782d0f33437bb2bf" redirectUrl:@"http://www.sharesdk.cn" universalLink:@"https://bocep2c.boce.cn/"];
        }];
    });
    
    return YES;
}

+(void)shareOpen{
    NSString *test=@"\"P2C产业电商\"是天津渤海商品交易所股份有限公司旗下服务大宗商品贸易的产业电商网站。渤海商品交易所产业电商平台始终坚持秉承服务实体经济的宗旨，通过市场化手段对各类资源要素进行合理配置，使生产者和消费者直接对接，解决生产企业“销售难、定价难、回款难、融资难”，保障消费者“真货、真便宜、真方便”的需求，是一个集商品、信息、资金、物流等多种要素于一体的综合型“P2C”产业电商平台。网站包含煤炭、农林、金属、石化四大品类上百个品种产品，以聚焦挂牌（竞价）及订单两种交易方式，以P2C电商理念解决现货贸易最基本最迫切的需求，实现产品合理定价、阳光销售。";
    
    NSMutableDictionary *shareParams =  [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:test
                                     images:@[[UIImage imageNamed:@"222"]]
                                        url:[NSURL URLWithString:@"https://www.bocep2c.com/AppDL.html"]
                                      title:@"P2C产业电商-手机轻松交易做大贸易"
                                       type:SSDKContentTypeAuto];
    
    SSUIShareSheetConfiguration *config=[[SSUIShareSheetConfiguration alloc] init];
     config.style=SSUIActionSheetStyleSystem;
    [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:config onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
                NSLog(@"分享成功!");
                break;
            case SSDKResponseStateFail:
                NSLog(@"分享失败%@",error);
                break;
            case SSDKResponseStateCancel:
                NSLog(@"分享已取消");
                break;
            default:
                break;
        }
    }];
}

+(void)ZoneShareForID:(NSString *)ID andTitle:(NSString *)title{
    NSString *test=@"\"P2C产业电商\"是天津渤海商品交易所股份有限公司旗下服务大宗商品贸易的产业电商网站。渤海商品交易所产业电商平台始终坚持秉承服务实体经济的宗旨，通过市场化手段对各类资源要素进行合理配置，使生产者和消费者直接对接，解决生产企业“销售难、定价难、回款难、融资难”，保障消费者“真货、真便宜、真方便”的需求，是一个集商品、信息、资金、物流等多种要素于一体的综合型“P2C”产业电商平台。网站包含煤炭、农林、金属、石化四大品类上百个品种产品，以聚焦挂牌（竞价）及订单两种交易方式，以P2C电商理念解决现货贸易最基本最迫切的需求，实现产品合理定价、阳光销售。";
    
    NSMutableDictionary *shareParams =  [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:test
                                     images:@[[UIImage imageNamed:@"222"]]
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.bocep2c.com/h5/shareZone?zoneId=%@",ID]]
                                      title:[NSString stringWithFormat:@"%@-P2C产业电商",title]
                                       type:SSDKContentTypeAuto];
    
    SSUIShareSheetConfiguration *config=[[SSUIShareSheetConfiguration alloc] init];
     config.style=SSUIActionSheetStyleSystem;
    [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:config onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
                NSLog(@"分享成功!");
                break;
            case SSDKResponseStateFail:
                NSLog(@"分享失败%@",error);
                break;
            case SSDKResponseStateCancel:
                NSLog(@"分享已取消");
                break;
            default:
                break;
        }
    }];
}

@end
