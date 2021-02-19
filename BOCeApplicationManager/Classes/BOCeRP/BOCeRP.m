//
//  BOCeRP.m
//  Industrial
//
//  Created by boce on 2021/2/8.
//  Copyright © 2021 boce. All rights reserved.
//

#import "BOCeRP.h"

@implementation BOCeRP

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    [RPSDK setup];
    return YES;
}

@end
