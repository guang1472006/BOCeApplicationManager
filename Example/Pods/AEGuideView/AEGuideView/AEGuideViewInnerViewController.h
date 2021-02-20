//
//  AEGuideViewInnerViewController.h
//  AEGuideViewDemo
//
//  Created by WangLin on 2016/11/11.
//  Copyright © 2016年 amberease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AEGuideViewConstants.h"

@interface AEGuideViewInnerViewController : UIViewController
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIColor *buttonBgColor;
@property (nonatomic, strong) UIColor *buttonBorderColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic,strong) AEGuildeViewCompletionBlock completion;
@property (nonatomic,weak) UIWindow* window;

@property (nonatomic,assign) NSInteger pageControlBottomSpace;
@property (nonatomic,assign) NSInteger lastButtonBottmSpace;
@end
