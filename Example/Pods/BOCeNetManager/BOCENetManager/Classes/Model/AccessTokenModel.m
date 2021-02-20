//
//  AccessTokenModel.m
//  p2c_iOS
//
//  Created by 张文学 on 2020/9/5.
//  Copyright © 2020 天津渤海商品交易所. All rights reserved.
//

#import "AccessTokenModel.h"

@implementation AccessTokenModel

- (BOOL)isExpired {
    return [self.expiration compare:[NSDate date]] == NSOrderedAscending;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    id expiresIn = [dic valueForKey:@"expires_in"];
    if (expiresIn && ![expiresIn isEqual:[NSNull null]]) {
        _expiration = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
    }
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [self yy_modelEncodeWithCoder:coder];
}

@end
