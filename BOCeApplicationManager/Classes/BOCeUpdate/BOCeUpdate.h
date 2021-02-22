//
//  BOCeUpdate.h
//  BoceGlobal
//
//  Created by boce on 2019/11/12.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCategories/YYCategories.h>
#import "BOCeApplicationManager.h"
#import "BOCeNetManager.h"
#import "BOCeContoller.h"

typedef NS_ENUM(NSUInteger, UpdateFlag) {
    UpdateFlag_Need=1,     //强制更新
    UpdateFlag_Last=-1,    //无需更新
    UpdateFlag_update=0,   //可选更新
};

typedef void(^BOCeUpdateFinish)(void);

NS_ASSUME_NONNULL_BEGIN

@interface BOCeUpdate : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@property(strong,nonatomic)BOCeUpdateFinish UpdateDidFinish;

@end

NS_ASSUME_NONNULL_END
