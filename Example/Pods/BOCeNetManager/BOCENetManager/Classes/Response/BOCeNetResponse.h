//
//  BOCeNetResponse.h
//  BOCeNetClient
//
//  Created by boce on 2019/7/18.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, BOCeNetStatus){
    BOCeNetStatusError = 0,
    BOCeNetStatusSuccess = 1
};

NS_ASSUME_NONNULL_BEGIN

@interface BOCeNetResponse : NSObject

/**
 返回内容(默认空字典)
 */
@property(strong,nonatomic)id content;

/**
 返回状态
 */
@property(assign,nonatomic)BOCeNetStatus status;

/**
 返回状态码
 */
@property(assign,nonatomic)NSInteger code;

/**
 返回信息
 */
@property(strong,nonatomic)NSError *error;

@end

NS_ASSUME_NONNULL_END
