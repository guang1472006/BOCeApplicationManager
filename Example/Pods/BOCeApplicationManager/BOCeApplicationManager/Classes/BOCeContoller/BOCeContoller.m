//
//  BOCeContoller.m
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeContoller.h"
#import "BOCeNetManager.h"

#define IsiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

@interface BOCeContoller ()

@property(strong,nonatomic)WMZDialog *detail;

@end

@implementation BOCeContoller

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    NSMutableArray *images = [NSMutableArray new];
    if(IsiPhoneXr){
        [images addObject:[UIImage imageNamed:@"Guidepage0XR"]];
        [images addObject:[UIImage imageNamed:@"Guidepage1XR"]];
        [images addObject:[UIImage imageNamed:@"Guidepage2XR"]];
        [images addObject:[UIImage imageNamed:@"Guidepage3XR"]];
    }else{
        [images addObject:[UIImage imageNamed:@"Guidepage0"]];
        [images addObject:[UIImage imageNamed:@"Guidepage1"]];
        [images addObject:[UIImage imageNamed:@"Guidepage2"]];
        [images addObject:[UIImage imageNamed:@"Guidepage3"]];
    }
    AEGuideView *guideView = [AEGuideView instance];
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]
                   withCompletionBlock:^(void){
        //加载主视图
        [BaseTabBarViewController addRootViewController];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"] boolValue]==NO) {
            @weakify(self)
            //加载弹窗
            self.detail.wEventClose = ^(id anyID, id otherData) {
                @strongify(self)
                self.detail=nil;
            };
            self.detail.wMyDiaLogView = ^UIView *(UIView *mainView) {
                @strongify(self)
                WKWebView *web=[[WKWebView alloc]initWithFrame:CGRectMake(0,0, mainView.frame.size.width,280)];
                [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.bocep2c.com/public/privacy.html"]]];
                [mainView addSubview:web];
                //button
                UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
                [mainView addSubview:know];
                know.titleLabel.font = [UIFont systemFontOfSize:14.0f];
                know.frame = CGRectMake(0, CGRectGetMaxY(web.frame), mainView.frame.size.width, 44);
                [know setTitle:@"同意" forState:UIControlStateNormal];
                [know setTitleColor:UIColorFromHex(0x333333) forState:UIControlStateNormal];
                [know addTarget:self action:@selector(ButtonAct:) forControlEvents:UIControlEventTouchUpInside];
                
                mainView.layer.masksToBounds = YES;
                mainView.layer.cornerRadius = 10;
                return know;
            };
            self.detail.wStart();
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
        }else{
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            [MobClick setAppVersion:version];
#if DEBUG
            UMConfigInstance.channelId=@"Develope";
#else
            UMConfigInstance.channelId=@"App Store";
#endif
            UMConfigInstance.appKey = @"5bea8586f1f5564fcf00002f";
            [MobClick startWithConfigure:UMConfigInstance];
        }
    }];
    return YES;
}

-(WMZDialog *)detail{
    if (!_detail) {
        _detail=[[WMZDialog alloc]init];
        _detail.wType=DialogTypeMyView;
        _detail.wShowAnimationSet(AninatonZoomIn).wHideAnimationSet(AninatonZoomOut);
    }
    return _detail;
}

-(void)ButtonAct:(UIButton *)button{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    #if DEBUG
    UMConfigInstance.channelId=@"Develope";
    #else
    UMConfigInstance.channelId=@"App Store";
    #endif
    UMConfigInstance.appKey = @"5bea8586f1f5564fcf00002f";
    [MobClick startWithConfigure:UMConfigInstance];
    [self.detail closeView];
}

@end
