//
//  BOCeAnimated.h
//  Industrial
//
//  Created by boce on 2020/1/10.
//  Copyright © 2020 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import <TABAnimated/TABAnimated.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOCeAnimated : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
