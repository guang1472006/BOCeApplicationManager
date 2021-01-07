//
//  BOCeContoller.m
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeContoller.h"
#import "BOCeNetManager.h"

@implementation BOCeContoller

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    [BaseTabBarViewController addRootViewController];
    return YES;
}

@end
