//
//  WXModel.h
//  Industrial
//
//  Created by boce on 2019/9/16.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXModel : BaseReq

/**
 商户ID
 */
@property(strong,nonatomic)NSString *partnerId;

/**
 预付单ID
 */
@property(strong,nonatomic)NSString *prepayId;

/**
 预留(先写死)
 */
@property(strong,nonatomic)NSString *package;

/**
 随机串(用于校验签名)
 */
@property(strong,nonatomic)NSString *nonceStr;

/**
 时间戳
 */
@property(assign,nonatomic)double timeStamp;


/**
 签名(根据随机串生成)
 */
@property(strong,nonatomic)NSString *sign;

@end

NS_ASSUME_NONNULL_END
