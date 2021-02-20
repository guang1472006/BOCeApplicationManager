//
//  AccessTokenModel.h
//  p2c_iOS
//
//  Created by 张文学 on 2020/9/5.
//  Copyright © 2020 天津渤海商品交易所. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccessTokenModel : NSObject

/**
 access_token
 */
@property(strong,nonatomic)NSString *access_token;

/**
 刷新token
 */
@property(strong,nonatomic)NSString *refresh_token;

/**
 scope
 */
@property(strong,nonatomic)NSString *scope;

/**
 token类型
 */
@property(strong,nonatomic)NSString *token_type;

/**
 过期时间
 */
@property(strong,nonatomic)NSDate *expiration;

-(BOOL)isExpired;

@end

NS_ASSUME_NONNULL_END
