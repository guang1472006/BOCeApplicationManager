//
//  NSObject+SelectorCrash.m
//  GridGovernance
//
//  Created by 吴欧 on 2017/12/14.
//  Copyright © 2017年 Bitvalue. All rights reserved.
//

#import "NSObject+SelectorCrash.h"
#import "NSObject+WOSwizzle.h"

@interface WOUnrecognizedSelectorSolveObject ()


@end

@implementation WOUnrecognizedSelectorSolveObject

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)addMethod, "v@:@");
    return YES;
}

id addMethod(id self, SEL _cmd){
    return 0;
}

@end

@implementation NSObject (SelectorCrash)

+ (void)wo_enableSelectorProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject *object = [[NSObject alloc] init];
        [object wo_instanceSwizzleMethod:@selector(forwardingTargetForSelector:) replaceMethod:@selector(wo_forwardingTargetForSelector:)];
    });
}

- (id)wo_forwardingTargetForSelector:(SEL)aSelector {
    if (class_respondsToSelector([self class], @selector(forwardInvocation:))) {
        IMP impOfNSObject = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
        IMP imp = class_getMethodImplementation([self class], @selector(forwardInvocation:));
        if (imp != impOfNSObject) {
            return nil;
        }
    }
    
    WOUnrecognizedSelectorSolveObject *solveObject = [WOUnrecognizedSelectorSolveObject new];
    solveObject.objc = self;
    return solveObject;
}

@end
