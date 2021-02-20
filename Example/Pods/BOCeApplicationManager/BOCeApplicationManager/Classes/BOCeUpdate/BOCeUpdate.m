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
    //版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion=[app_Version stringByReplacingOccurrencesOfString:@"." withString:@""];
    //开始请求
    [[BOCeNetManager shareManager] sendRequestWithRequest:^BOCeNetRequest * _Nonnull(BOCeNetRequest * _Nonnull request) {
        request.method=BOCEGET;
        request.specName=@"member";
        request.url=[NSString stringWithFormat:@"/open/app/version/info/ios/%@",appVersion];
        request.enableCache=NO;
        return request;
    } complete:^(BOCeNetResponse * _Nonnull response){
        if ([response.content containsObjectForKey:@"update_type"]){
            NSInteger flag=[[response.content objectForKey:@"update_type"] integerValue];
            //    新版本号
            if(flag==UpdateFlag_update){//可选更新
                
                UIAlertController *controller=[UIAlertController alertControllerWithTitle:nil message:@"发现新版本" preferredStyle:UIAlertControllerStyleAlert];
                
                [controller addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {//跳转到APPStore更新
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[response.content objectForKey:@"downloadUrl"]]];
                }]];
                
                [controller addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
                }]];
                
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:controller animated:YES completion:nil];
                });
                
            }else if(flag==UpdateFlag_Need){//强制更新
                
                UIAlertController *controller=[UIAlertController alertControllerWithTitle:nil message:@"发现新版本" preferredStyle:UIAlertControllerStyleAlert];
                
                [controller addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {//跳转到APPStore更新
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[response.content objectForKey:@"downloadUrl"]]];
                    exit(0);
                }]];
                
                [controller addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
                    exit(0);
                }]];
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:controller animated:YES completion:nil];
                });
                
            }else{//不更新
                
                
            }
        }
    }] ;
    return YES;
}

@end
