//
//  BOCePay.h
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXService.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOCePay : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation;

@end

NS_ASSUME_NONNULL_END
