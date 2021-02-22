//
//  BOCeContoller.m
//  Industrial
//
//  Created by boce on 2019/10/22.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeContoller.h"
#import "BOCeNetManager.h"

@implementation UIImage (SVGManager)

+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size{
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    svgImage.size = size;
    return svgImage.UIImage;
}

@end

@interface BOCeContoller ()

@property(strong,nonatomic)WMZDialog *detail;

@end

@implementation BOCeContoller

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    
    //图片数组
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (int i=0; i<4; i++){
        UIImage *image0=[UIImage svgImageNamed:[NSString stringWithFormat:@"Guidepage%dXR",i] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        if (image0){
            [images addObject:image0];
        }
    }
    
    //首次安装展示
    if(images){
        AEGuideView *guideView = [AEGuideView instance];
        [guideView showGuideViewWithImages:images
                            andButtonTitle:@"立即体验"
                       andButtonTitleColor:[UIColor whiteColor]
                          andButtonBGColor:[UIColor clearColor]
                      andButtonBorderColor:[UIColor whiteColor]
                       withCompletionBlock:^(void){
            if (self.startLoadRootVC){
                self.startLoadRootVC();
            }
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
                    [know setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    }
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
