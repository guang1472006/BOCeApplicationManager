//
//  BOCeContoller.h
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOCeApplicationManager.h"
#import <AEGuideView/AEGuideView.h>
#import <WebKit/WebKit.h>
#import "UMMobClick/MobClick.h"
#import "WMZDialog.h"
#import <SVGKit/SVGKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^didFinish)(void);

@interface UIImage (SVGManager)
/**
 show svg image

 @param name svg name
 @param size image size
 @return svg image
 */
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size;

@end

@interface BOCeContoller : NSObject<BOCeApplicationDelegate>

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions;

@property(strong,nonatomic)didFinish startLoadRootVC;

@end

NS_ASSUME_NONNULL_END
