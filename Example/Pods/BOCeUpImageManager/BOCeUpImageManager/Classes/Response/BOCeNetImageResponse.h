//
//  BOCeNetImageResponse.h
//  Industrial
//
//  Created by boce on 2019/11/26.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BOCeNetImageRequest;

typedef NS_ENUM (NSUInteger, BOCeImageUpStatus){
    BOCeImageUpStatusFail = 0,
    BOCeImageUpStatusSuccess = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface BOCeNetImageResponse : NSObject

/**
 请求
 */
@property(strong,nonatomic)BOCeNetImageRequest *request;

/**
 状态
 */
@property(assign,nonatomic)BOCeImageUpStatus status;

/**
 错误信息
 */
@property(strong,nonatomic)NSError *error;

@end

NS_ASSUME_NONNULL_END
