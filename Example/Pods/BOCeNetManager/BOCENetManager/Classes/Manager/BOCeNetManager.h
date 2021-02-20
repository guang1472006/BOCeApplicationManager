//
//  BOCeNetManager.h
//  BOCeNetClient
//
//  Created by boce on 2019/7/18.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <YYCategories/YYCategories.h>

#import "AccessTokenManager.h"
#import "BOCeNetRequest.h"
#import "BOCeNetResponse.h"
#import "BOCeNetLogger.h"
#import "BOCeCache.h"

#define AppclientID @"app-p2c-client"
#define Appsecret @"6ktoMtwPf6foIQbtzVHG3LIAUxjRXohX"
#define NeedOAuthCode 99999999

#define CodeName @"status"

#if DEBUG  //测试
#define BASEURL @"http://192.168.6.184:9001"
#else      //正式
#define BASEURL @"https://api.bocep2c.com:9004/v2"
#endif

/**
 默认请求头
 */
typedef NSDictionary *_Nullable(^requestConfig)(BOCeNetRequest * _Nonnull  request);

/**
 默认证书
 */
typedef NSString *_Nullable(^CerConfig)(BOOL allowInvalidCertificates,BOOL setValidatesDomainName);

NS_ASSUME_NONNULL_BEGIN

@interface BOCeNetManager : NSObject

//单列模式(系统也为单例模式)
+ (nonnull instancetype)shareManager;

@property(nonatomic,strong) AFHTTPSessionManager * sessionManager;

//基本URL
@property(nonatomic,strong) NSString *baseUrl;

//请求头默认配置
@property(strong,nonatomic)requestConfig defaultConfig;

//验证证书
@property(strong,nonatomic)CerConfig Cerfig;

//开始请求
+(void)startNetWork;

//结束请求
+(void)endNetWork;

//发送请求
- (void)sendRequestWithRequest:(BOCeNetRequest * (^)(BOCeNetRequest *request))block complete:(void (^)(BOCeNetResponse *response))complete;

@end

NS_ASSUME_NONNULL_END
