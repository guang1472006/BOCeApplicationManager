//
//  BOCeUpImageManager.h
//  ss
//
//  Created by boce on 2021/1/12.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/AliyunOSSiOS.h>
#import <BOCeNetManager/BOCeNetManager.h>

#import "BOCeNetImageResponse.h"
#import "BOCeNetImageRequest.h"
#import "BOCeImageToken.h"


#if DEBUG  //测试
#define endpoint @"http://oss-cn-qingdao.aliyuncs.com"
#define BucketName @"boce-p2c"
#else      //正式
#define endpoint @"http://oss-cn-beijing.aliyuncs.com"
#define BucketName @"p2c-new"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BOCeUpImageManager : NSObject

+ (nonnull instancetype)shareManager;

//发送图片请求
- (void)sendImageWithRequest:(BOCeNetImageRequest * (^)(BOCeNetImageRequest *request))block complete:(void (^)(BOCeNetImageResponse *response))complete;

@end

NS_ASSUME_NONNULL_END
