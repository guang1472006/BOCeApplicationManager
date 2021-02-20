//
//  NSBundle+AEGuideView.m
//  AEGuideViewDemo
//
//  Created by WangLin on 2016/11/13.
//  Copyright © 2016年 amberease. All rights reserved.
//

#import "NSBundle+AEGuideView.h"
#import "AEGuideView.h"

@implementation NSBundle (AEGuideView)

+ (NSBundle *)AEGuideView_LibraryBundle {
    return [self bundleWithURL:[self AEGuideView_LibraryBundleURL]];
}

+ (NSURL *)AEGuideView_LibraryBundleURL {
    NSBundle *bundle = [NSBundle bundleForClass:[AEGuideView class]];
    return [bundle URLForResource:@"AEGuideView" withExtension:@"bundle"];
}

@end
