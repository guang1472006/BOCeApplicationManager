//
//  BOCeApplicationManager.h
//  BoceGlobal
//
//  Created by boce on 2019/10/9.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BOCeApplicationDelegate<UIApplicationDelegate>

@end

@interface BOCeApplicationManager : UIResponder

+(id)sharedInstance;

-(void)loadModulesWithPlistFile:(NSString *)plistFile;

-(NSArray<id<BOCeApplicationDelegate>> *)allModules;

@end

NS_ASSUME_NONNULL_END
