//
//  BOCeStart.h
//  BoceGlobal
//
//  Created by boce on 2019/11/13.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import <Appirater/Appirater.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOCeStart : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
