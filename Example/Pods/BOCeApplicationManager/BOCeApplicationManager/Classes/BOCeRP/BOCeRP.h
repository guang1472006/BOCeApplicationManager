//
//  BOCeRP.h
//  Industrial
//
//  Created by boce on 2021/2/8.
//  Copyright © 2021 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import <RPSDK/RPSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOCeRP : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
