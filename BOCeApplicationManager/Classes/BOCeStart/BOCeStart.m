//
//  BOCeStart.m
//  BoceGlobal
//
//  Created by boce on 2019/11/13.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeStart.h"

@implementation BOCeStart

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    [Appirater setAppId:@"1441099229"]; // 设定 App Id，使用者如果点击评分按钮的话，就会打开 AppStore，直接进入这个 App 頁面
    [Appirater setDaysUntilPrompt:1]; // 设定要使用多少天之后才跳出询问框
    [Appirater setUsesUntilPrompt:10]; //设定要使用多少次之后才跳出询问框
    [Appirater setSignificantEventsUntilPrompt:-1]; //设定使用者触发特定事件多少次之后才跳出
    [Appirater setTimeBeforeReminding:2]; //设定使用者选择<稍后>多少天之后再跳出
    [Appirater appLaunched:YES]; //这行代码一定要放在这个方法的最后面
    return YES;
}

@end
