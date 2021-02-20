//
//  BOCeImageToken.h
//  p2c_iOS
//
//  Created by 张文学 on 2020/9/5.
//  Copyright © 2020 天津渤海商品交易所. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BOCeImageToken : NSObject

/// ID
@property(strong,nonatomic)NSString *AccessKeyId;

/// Secret
@property(strong,nonatomic)NSString *AccessKeySecret;

/// token
@property(strong,nonatomic)NSString *SecurityToken;

/// 过期时间
@property(strong,nonatomic)NSString *Expiration;

@end

NS_ASSUME_NONNULL_END
