//
//  BOCeNetLogger.h
//  BOCENetManager
//
//  Created by boce on 2021/1/11.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "BOCeNetResponse.h"
#import "BOCeNetRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BOCeNetLogger : NSObject

//返回Log
@property(strong,nonatomic)BOCeNetResponse *response;

//请求Log
@property(strong,nonatomic)BOCeNetRequest *request;

//请求网络状态
@property(assign,nonatomic)AFNetworkReachabilityStatus status;

@end

NS_ASSUME_NONNULL_END
