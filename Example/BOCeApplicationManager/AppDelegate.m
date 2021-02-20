//
//  AppDelegate.m
//  BOCeApplicationManager
//
//  Created by boce on 2021/2/19.
//

#import "AppDelegate.h"
#import <BOCeApplicationManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

//启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"BOCeApplication" ofType:@"plist"];
    [[BOCeApplicationManager sharedInstance] loadModulesWithPlistFile:path];
    for (id<BOCeApplicationDelegate> module in [[BOCeApplicationManager sharedInstance] allModules]){
        if ([module respondsToSelector:_cmd]){
            [module application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

//通知
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (id<BOCeApplicationDelegate> module in [[BOCeApplicationManager sharedInstance] allModules]){
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

//通知
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (id<BOCeApplicationDelegate> module in [[BOCeApplicationManager sharedInstance] allModules]){
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

//通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    for (id<BOCeApplicationDelegate> module in [[BOCeApplicationManager sharedInstance] allModules]){
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

//通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id<BOCeApplicationDelegate> module in [[BOCeApplicationManager sharedInstance] allModules]){
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

//禁用旋转
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}

//打开APP
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    for (id<BOCeApplicationDelegate> module in [[BOCeApplicationManager sharedInstance] allModules]){
        if ([module respondsToSelector:_cmd]){
            [module application:app openURL:url options:options];
        }
    }
    return YES;
}

@end
