//
//  BOCeNetRequest.h
//  BOCeNetClient
//
//  Created by boce on 2019/7/18.
//  Copyright © 2019 boce. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,BOCeNetMethod){
    BOCEGET  =2,
    BOCEPOST =3,
    BOCEPUT  =4,
    BOCEDELE =5,
};

NS_ASSUME_NONNULL_BEGIN

@interface BOCeNetRequest : NSObject

//请求URL
@property(strong,nonatomic)NSString *url;

//空间名
@property(strong,nonatomic)NSString *specName;

//请求参数
@property(strong,nonatomic)NSDictionary *parameters;

//是否加入token
@property(assign,nonatomic)BOOL enableToken;

//是否缓存结果
@property(assign,nonatomic)BOOL enableCache;

//请求方法
@property(assign,nonatomic)BOCeNetMethod method;

//参数放在body里还是头
@property(assign,nonatomic)BOOL enableBody;

//是否显示遮罩
@property(assign,nonatomic)BOOL enableMark;

@end

NS_ASSUME_NONNULL_END
