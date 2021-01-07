//
//  BOCeBugCommon.h
//  Industrial
//
//  Created by 张文学 on 2020/3/2.
//  Copyright © 2020 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import "UMMobClick/MobClick.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOCeBugCommon : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
