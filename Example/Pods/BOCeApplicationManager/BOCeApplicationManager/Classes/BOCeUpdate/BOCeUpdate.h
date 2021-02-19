//
//  BOCeUpdate.h
//  BoceGlobal
//
//  Created by boce on 2019/11/12.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import "BOCeNetManager.h"
#import <YYCategories/YYCategories.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOCeUpdate : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
