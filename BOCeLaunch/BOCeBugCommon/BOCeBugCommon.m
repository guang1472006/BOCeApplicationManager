//
//  BOCeBugCommon.m
//  Industrial
//
//  Created by 张文学 on 2020/3/2.
//  Copyright © 2020 boce. All rights reserved.
//

#import "BOCeBugCommon.h"

@implementation BOCeBugCommon

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
#if DEBUG
    UMConfigInstance.channelId=@"Develope";
#else
    UMConfigInstance.channelId=@"App Store";
#endif
    UMConfigInstance.appKey = @"5bea8586f1f5564fcf00002f";
    [MobClick startWithConfigure:UMConfigInstance];
    return YES;
}

@end
