//
//  BOCeUpdate.m
//  BoceGlobal
//
//  Created by boce on 2019/11/12.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeUpdate.h"

@implementation BOCeUpdate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:( nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    [[BOCeNetManager shareManager] sendRequestWithRequest:^BOCeNetRequest * _Nonnull(BOCeNetRequest * _Nonnull request) {
        request.method=BOCEGET;
        request.specName=@"member";
        request.url=@"/open/app/version/info/ios";
        request.enableCache=NO;
        request.enableSinger=NO;
        return request;
    } complete:^(BOCeNetResponse * _Nonnull response) {
        if (response.status==BOCeNetStatusSuccess) {
            NSString *version=[response.content objectForKey:@"version"];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            //    新版本号
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSString *appVersion=[app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
            if([appVersion integerValue]<[version integerValue]){//有新版本
                UIAlertController *controller=[UIAlertController alertControllerWithTitle:nil message:@"发现新版本" preferredStyle:UIAlertControllerStyleAlert];
                BOOL forcedUpdate=[[response.content objectForKey:@"forceUpdate"] boolValue];
                [controller addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {//跳转到APPStore更新
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[response.content objectForKey:@"downloadUrl"]]];
                    exit(0);
                }]];
                if (forcedUpdate) {//强制更新
                    [controller addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                        exit(0);
                    }]];
                }else{
                    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
                    }]];
                }
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:controller animated:YES completion:nil];
                });
            }
        }
    }] ;
    return YES;
}

@end
