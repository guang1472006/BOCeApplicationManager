//
//  BOCeShare.h
//  BoceGlobal
//
//  Created by boce on 2019/10/10.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOCeShare : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions: (nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

+(void)shareOpen;

+(void)ZoneShareForID:(NSString *)ID andTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
