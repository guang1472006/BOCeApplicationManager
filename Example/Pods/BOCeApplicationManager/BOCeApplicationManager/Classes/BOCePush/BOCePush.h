//
//  BOCePush.h
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import <UserNotifications/UserNotifications.h>
#import "JPUSHService.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOCePush : NSObject<BOCeApplicationDelegate,JPUSHRegisterDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler;

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error;



@end

NS_ASSUME_NONNULL_END
