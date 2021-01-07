//
//  BOCeCrashProtector.h
//  p2c_iOS
//
//  Created by 张文学 on 2020/9/5.
//  Copyright © 2020 天津渤海商品交易所. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import "WOCrashProtectorManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOCeCrashProtector : NSObject

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
