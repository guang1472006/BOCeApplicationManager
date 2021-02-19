//
//  BOCeApplicationManager.m
//  BoceGlobal
//
//  Created by boce on 2019/10/9.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeApplicationManager.h"

@interface BOCeApplicationManager ()

@property (nonatomic, strong) NSMutableArray<id<BOCeApplicationDelegate>> *modules;

@end

@implementation BOCeApplicationManager

+ (instancetype)sharedInstance
{
    static BOCeApplicationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (NSMutableArray<id<BOCeApplicationDelegate>> *)modules
{
    if (!_modules) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (void)addModule:(id<BOCeApplicationDelegate>) module
{
    if (![self.modules containsObject:module]) {
        [self.modules addObject:module];
    }
}

- (void)loadModulesWithPlistFile:(NSString *)plistFile
{
    NSArray<NSString *> *moduleNames = [NSArray arrayWithContentsOfFile:plistFile];
    for (NSString *moduleName in moduleNames) {
        id<BOCeApplicationDelegate> module = [[NSClassFromString(moduleName) alloc] init];
        [self addModule:module];
    }
}

- (NSArray<id<BOCeApplicationDelegate>> *)allModules
{
    return self.modules;
}

@end
