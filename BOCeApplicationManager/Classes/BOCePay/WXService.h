//
//  WXService.h
//  Industrial
//
//  Created by boce on 2019/9/3.
//  Copyright © 2019 boce. All rights reserved.
//

#import "WXApi.h"
#import "WXModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^WXResponseBlock)(NSError * _Nullable error);

@interface WXService : NSObject<WXApiDelegate>

+(instancetype)shareWXService;

@property(strong,nonatomic)NSString *orderID;

@property(strong,nonatomic)WXResponseBlock block;

@end

NS_ASSUME_NONNULL_END
