//
//  BOCeContoller.h
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
//#import "BaseTabbarViewController.h"
#import <AEGuideView/AEGuideView.h>
#import <WebKit/WebKit.h>
#import "UMMobClick/MobClick.h"
#import "WMZDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOCeContoller : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@end

NS_ASSUME_NONNULL_END
