//
//  BOCeUpImageManager.m
//  ss
//
//  Created by boce on 2021/1/12.
//

#import "BOCeUpImageManager.h"

@interface BOCeUpImageManager()

/**
 图片上传manager
 */
@property(nonatomic,strong) OSSClient *client;

/**
 图片上传配置
 */
@property(nonatomic,strong) OSSClientConfiguration *conf;


@end

@implementation BOCeUpImageManager

+ (nonnull instancetype)shareManager{
    static dispatch_once_t onceToken;
    static BOCeUpImageManager *manager=nil;
    dispatch_once(&onceToken, ^{
        manager=[[BOCeUpImageManager alloc]init];
    });
    return manager;
}

- (void)sendImageWithRequest:(BOCeNetImageRequest * (^)(BOCeNetImageRequest *request))block complete:(void (^)(BOCeNetImageResponse *response))complete{
    
    __block BOCeNetImageRequest *request=[[BOCeNetImageRequest alloc]init];
    
    request=block(request);
    //必填
    request.bucketName=BucketName;
    //必填
    request.objectKey=[NSString stringWithFormat:@"%@/%@",request.filePath,request.fileName];
    NSData *data=UIImagePNGRepresentation(request.uploadImage);
    BOCeNetImageResponse *response=[[BOCeNetImageResponse alloc]init];
    if(data.length>request.limitLength*1024*1024){
        response.status=BOCeImageUpStatusFail;
        response.error=[NSError errorWithDomain:NSCocoaErrorDomain code:-10001 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"图片大小限制%ldM",(long)request.limitLength]}];
        complete(response);
        return;
    }
    request.uploadingData=data;
    OSSTask *putTask=[self.client putObject:request];
    __weak BOCeNetImageRequest *weakrequest=request;
    request.uploadProgress = ^(int64_t bytesSent,int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        __strong BOCeNetImageRequest *strongrequest=weakrequest;
        if (strongrequest.BOCeUploadProgress) {
            strongrequest.BOCeUploadProgress(totalByteSent/request.uploadingData.length);
        }
    };
    
    [putTask continueWithBlock:^id _Nullable(OSSTask * _Nonnull task){
        BOCeNetImageResponse *response=[[BOCeNetImageResponse alloc]init];
        response.request=request;
        if (!task.error){
            response.status=BOCeImageUpStatusSuccess;
        }else{
            response.status=BOCeImageUpStatusFail;
            response.error=task.error;
        }
        complete(response);
        return nil;
    }];
}

#pragma mark Lazy
-(OSSClient *)client{
    if (!_client){
        id<OSSCredentialProvider> credential=[[OSSAuthCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * _Nullable{
            OSSFederationToken *token=[[OSSFederationToken alloc ]init];
            dispatch_semaphore_t semap=dispatch_semaphore_create(0);
            [[BOCeNetManager shareManager] sendRequestWithRequest:^BOCeNetRequest * _Nonnull(BOCeNetRequest * _Nonnull request) {
                request.method=BOCEGET;
                request.url=@"/aliyun/token/appGetToken";
                request.parameters=@{};
                return request;
            } complete:^(BOCeNetResponse * _Nonnull response) {
                if (response.status==BOCeNetStatusSuccess){
                    BOCeImageToken *tokens=[BOCeImageToken yy_modelWithDictionary:response.content];
                    token.tAccessKey=tokens.AccessKeyId;
                    token.tSecretKey=tokens.AccessKeySecret;
                    token.tToken=tokens.SecurityToken;
                    token.expirationTimeInGMTFormat=tokens.Expiration;
                }
                dispatch_semaphore_signal(semap);
            }];
            dispatch_semaphore_wait(semap,DISPATCH_TIME_FOREVER);
            return token;
        }];
        _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    }
    return _client;
}

-(OSSClientConfiguration * )conf{
    if (!_conf) {
        _conf=[OSSClientConfiguration new];
        _conf.maxRetryCount = 3; // 网络请求遇到异常失败后的重试次数
        _conf.timeoutIntervalForRequest = 30; // 网络请求的超时时间
        _conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
    }
    return _conf;
}


@end
