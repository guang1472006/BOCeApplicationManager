//
//  BOCeNetManager.m
//  BOCeNetClient
//
//  Created by boce on 2019/7/18.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeNetManager.h"

@interface BOCeNetManager ()

@property(nonatomic,strong) BOCeNetLogger *logger;

@end

@implementation BOCeNetManager

#pragma  mark Lazy
+(void)load{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (nonnull instancetype)shareManager{
    static dispatch_once_t onceToken;
    static BOCeNetManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[BOCeNetManager alloc]init];
    });
    return manager;
}

-(AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager){
        _sessionManager=[AFHTTPSessionManager manager];
        _sessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval=5;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", @"application/x-www-form-urlencoded",nil];
    }
    return _sessionManager;
}

-(void)setTimeOutForRequestInterval:(NSTimeInterval) timeout{
    [self.sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.sessionManager.requestSerializer.timeoutInterval=timeout;
    [self.sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

-(BOCeNetLogger *)logger{
    if (!_logger) {
        _logger=[[BOCeNetLogger alloc]init];
    }
    return _logger;
}

-(NSString *)baseUrl{
    if (!_baseUrl) {
        _baseUrl=BASEURL;
    }
    return _baseUrl;
}

-(void)gotoLogin:(void (^)(BOCeNetResponse *response))blockOne{
    BOCeNetResponse *response=[[BOCeNetResponse alloc]init];
    response.code=NeedOAuthCode;
    blockOne(response);
}

+(void)startNetWork{
    //主队列更新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showInfoWithStatus:@"加载中"];
    });
}

+(void)endNetWork{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

-(BOCeNetResponse *)configErrorResponse:(NSError *)error{
    BOCeNetResponse *response=[[BOCeNetResponse alloc]init];
    NSData *data=[error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSError *serror=nil;
    if (data){
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serror];
        if (!serror){
            if ([@"invalid_token" isEqualToString:[dic objectForKey:@"error"]]) {
                [[AccessTokenManager sharedManager] CacheTokenModel:nil];
            }
        }
    }
    response.code=error.code;
    response.status=BOCeNetStatusError;
    response.error=error;
    return  response;
}

-(BOCeNetResponse *)configSuccessResponse:(id)responseObject and:(BOCeNetRequest *)request{
    BOCeNetResponse *response=[[BOCeNetResponse alloc]init];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if ([[responseObject allKeys] containsObject:CodeName]){
            //服务器操作成功
            if (![[responseObject objectForKey:CodeName] integerValue]){
                response.code=200;
                if ([[responseObject allKeys] containsObject:@"data"]){
                    response.status=BOCeNetStatusSuccess;
                    if ([responseObject objectForKey:@"data"]!=nil&&[responseObject objectForKey:@"data"]!=[NSNull null]) {
                        response.content=[responseObject objectForKey:@"data"];
                    }
                    //进行缓存
                    //  [self cacheResponse:request andResponse:response.content];
                }else{
                    response.status=BOCeNetStatusError;
                    response.code=[[responseObject objectForKey:CodeName] integerValue];
                }
            //服务器操作失败
            }else{
                response.status=BOCeNetStatusError;
                response.code=[[responseObject objectForKey:CodeName] integerValue];
                response.error=[NSError errorWithDomain:NSCocoaErrorDomain code:20000 userInfo:@{NSLocalizedDescriptionKey:[responseObject objectForKey:@"errorMsg"]}];
            }
            //登录成功
        }else if([responseObject objectForKey:@"token_type"]){
            response.code=200;
            response.status=BOCeNetStatusSuccess;
            response.content=responseObject;
        }else if([responseObject objectForKey:@"ret"]){
            response.code=200;
            response.status=BOCeNetStatusSuccess;
            response.content=responseObject;
        }
    }
    return response;
}

#pragma mark Request
-(void)sendRequest:(BOCeNetRequest *)request and:(void (^)(BOCeNetResponse *response))blockOne{
    if (request.enableMark){
        [BOCeNetManager startNetWork];
    }
    __block BOCeNetLogger *logger=[[BOCeNetLogger alloc]init];
    logger.request=request;
    switch (request.method) {
        case BOCEGET:
        {
            [self.sessionManager GET:[NSString stringWithFormat:@"%@%@",self.baseUrl,request.url] parameters:request.parameters headers:[self configWithRequest:request] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configSuccessResponse:responseObject and:request];
                logger.response=response;
                blockOne(response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configErrorResponse:error];
                logger.response=response;
                blockOne(response);
            }];
        }
            break;
        case BOCEPUT:
        {
            [self.sessionManager PUT:[NSString stringWithFormat:@"%@%@",self.baseUrl,request.url] parameters:request.parameters headers:[self configWithRequest:request] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configSuccessResponse:responseObject and:request];
                logger.response=response;
                blockOne(response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configErrorResponse:error];
                logger.response=response;
                blockOne(response);
            }];
        }
            break;
        case BOCEDELE:
        {
            [self.sessionManager DELETE:[NSString stringWithFormat:@"%@%@",self.baseUrl,request.url] parameters:request.parameters headers:[self configWithRequest:request] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configSuccessResponse:responseObject and:request];
                logger.response=response;
                blockOne(response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configErrorResponse:error];
                logger.response=response;
                blockOne(response);
            }];
        }
            break;
        default:
        {
            [self.sessionManager POST:[NSString stringWithFormat:@"%@%@",self.baseUrl,request.url] parameters:request.parameters headers:[self configWithRequest:request] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configSuccessResponse:responseObject and:request];
                logger.response=response;
                blockOne(response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               if (request.enableMark) {
                    [BOCeNetManager endNetWork];
                }
                BOCeNetResponse *response=[self configErrorResponse:error];
                logger.response=response;
                blockOne(response);
            }];
        }
            break;
    }
}

-(void)sendRequest:(BOCeNetRequest *)request andToken:(BOOL)enable and:(void (^)(BOCeNetResponse *response))blockOne{
    //加token
    if (enable){
        self.sessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        [self setTimeOutForRequestInterval:10.f];
        _baseUrl=[NSString stringWithFormat:@"%@/%@",BASEURL,request.specName];
        AccessTokenModel *credent=[[AccessTokenManager sharedManager] tokenWithEnCode];
        if (credent!=nil){
            [self.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",credent.access_token] forHTTPHeaderField:@"Authorization"];
        }
    }
    
    //加defaultConfig
    [[self configWithRequest:request] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop){
        [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    //Delete配置(参数加载body里)
    if (request.enableBody){
         [self.sessionManager.requestSerializer setHTTPMethodsEncodingParametersInURI:[NSSet setWithObjects:@"GET", @"HEAD",nil]];
    }else{
         [self.sessionManager.requestSerializer setHTTPMethodsEncodingParametersInURI:[NSSet setWithObjects:@"GET", @"HEAD",@"DELETE",nil]];
    }
    
    // Https配置
    if(self.Cerfig){
        NSString *path=self.Cerfig(YES,NO);
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSData * cerData = [NSData dataWithContentsOfFile:path];
            if (cerData.length>0){
                self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
                // 客户端是否信任非法证书
               self.sessionManager.securityPolicy.allowInvalidCertificates = YES;
                // 是否在证书域字段中验证域名
                [self.sessionManager.securityPolicy setValidatesDomainName:NO];
            }
        }
    }
    //  response缓存配置
    if (request.enableCache){
        if ([BOCeCache isExpired]){//缓存过期
            [self sendRequest:request and:blockOne];
        }else{
            //默认只缓存Open接口
            if([request.url containsString:@"open"]){
                NSDictionary *dic=[BOCeCache httpCacheForURL:[NSString stringWithFormat:@"%@%@",self.baseUrl,request.url] parameters:request.parameters];
                if (dic){
                    blockOne([self configSuccessResponse:dic and:request]);
                }else{
                    [self sendRequest:request and:blockOne];
                }
            }else{
                [self sendRequest:request and:blockOne];
            }
        }
    }else{
        [self sendRequest:request and:blockOne];
    }
}

- (void)sendRequestWithRequest:(BOCeNetRequest * (^)(BOCeNetRequest *request))block complete:(void (^)(BOCeNetResponse *response))blockOne{
    BOCeNetRequest *request=[[BOCeNetRequest alloc]init];
    block(request);
    //是否为登录接口
    if ([request.url containsString:@"oauth"]){
        _baseUrl=BASEURL;
        self.sessionManager.requestSerializer=[AFHTTPRequestSerializer serializer];
        [self setTimeOutForRequestInterval:6.f];
        [self.sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:AppclientID password:Appsecret];
        [self sendRequest:request andToken:NO and:blockOne];
    //是否为open接口
    }else if([request.url containsString:@"open"]){
         _baseUrl=[NSString stringWithFormat:@"%@/%@",BASEURL,request.specName];
         self.sessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
         [self setTimeOutForRequestInterval:4.f];
        //默认不带token
        if(request.enableToken) {
            [self sendRequest:request andToken:YES and:blockOne];
        }else{
            [self sendRequest:request andToken:NO and:blockOne];
        }
    //token接口
    }else{
        AccessTokenModel *credent=[[AccessTokenManager sharedManager] tokenWithEnCode];
        //如果token过期 刷新
        if (credent){
            if (credent.isExpired) {//如果token过期 刷新
                [self refreshTokenWithRequest:request andCredent:credent andResponse:blockOne];
            }else{
                //没过期去请求
                [self sendRequest:request andToken:YES and:blockOne];
            }
        }else{
             //goto login
            [self gotoLogin:blockOne];
        }
    }
}

-(void)refreshTokenWithRequest:(BOCeNetRequest *)request andCredent:(AccessTokenModel *)credent andResponse:(void (^)(BOCeNetResponse *response))blockOne{
    self.sessionManager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [self setTimeOutForRequestInterval:10.f];
    [self.sessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:AppclientID password:Appsecret];
    [self.sessionManager POST:[NSString stringWithFormat:@"%@/oauth/token",BASEURL] parameters:@{@"grant_type":@"refresh_token",@"refresh_token":credent.refresh_token} headers:[self configWithRequest:request] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if ([responseObject isKindOfClass:[NSDictionary class]]){
            AccessTokenModel *token=[AccessTokenModel yy_modelWithDictionary:responseObject];
            [[AccessTokenManager sharedManager] CacheTokenModel:token];
            [self sendRequest:request andToken:YES and:blockOne];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        //goto login
        [self gotoLogin:blockOne];
    }];
}

-(void)cacheResponse:(BOCeNetRequest *)request andResponse:(NSDictionary *)response{
    //缓存open接口数据
    if (request.enableCache){
        if ([request.url containsString:@"open"]){
            [BOCeCache setHttpCache:response URL:request.url parameters:request.parameters];
        }
    }
}

-(NSDictionary *)configWithRequest:(BOCeNetRequest *)request{
    NSString *body=nil;
    NSString *md5String=nil;
    NSError *sError=nil;
    if (request.parameters.count>0){
        NSData * data=[NSJSONSerialization dataWithJSONObject:request.parameters options:NSJSONWritingPrettyPrinted error:&sError];
        if (!sError&&data!=nil){
            NSString *name=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if (name) {
                body=[name stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                body=[body stringByReplacingOccurrencesOfString:@" " withString:@""];
                body=[body stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                body=[body stringByReplacingOccurrencesOfString:@"\\s" withString:@""];
                body=[body stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                md5String=[[NSString stringWithFormat:@"/%@%@%@%.0fQ9FPkLXD7zXQQl8P",request.specName,request.url,body,[[NSDate date] timeIntervalSince1970]] md5String];
            }
        }
    }else{
        switch (request.method) {
            case BOCEDELE:
            case BOCEGET:
            {
                md5String=[[NSString stringWithFormat:@"/%@%@%.0fQ9FPkLXD7zXQQl8P",request.specName,request.url,[[NSDate date] timeIntervalSince1970]] md5String];
            }
                break;
            default:
            {
                md5String=[[NSString stringWithFormat:@"/%@%@{}%.0fQ9FPkLXD7zXQQl8P",request.specName,request.url,[[NSDate date] timeIntervalSince1970]] md5String];
            }
                break;
        }
    }
    return @{@"timestamp":[NSString stringWithFormat:@"%.0f" ,[[NSDate date] timeIntervalSince1970]],@"sign":md5String};
}

@end
