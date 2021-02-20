//
//  BOCeCache.m
//  BOCeNetClient
//
//  Created by boce on 2019/7/18.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeCache.h"
#import <YYCache/YYCache.h>

static NSString *const BOCeNetworkResponseCache = @"BOCeNetworkResponseCache";
static NSString *const BOCeNetworkCacheTime = @"BOCeNetworkCacheTime";

@interface BOCeCache ()

@end


@implementation BOCeCache

static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:BOCeNetworkResponseCache];
    NSDateFormatter *dataFormatt=[[NSDateFormatter alloc]init];
    [dataFormatt setDateFormat:@"yyyy-MM-dd HH:mm:SSS"];
    [_dataCache setObject:[dataFormatt stringFromDate:[NSDate dateWithTimeIntervalSinceNow:CacheExpiredTime]] forKey:BOCeNetworkCacheTime];
}

+(BOOL)isExpired{
    NSDateFormatter *dataFormatt=[[NSDateFormatter alloc]init];
    [dataFormatt setDateFormat:@"yyyy-MM-dd HH:mm:SSS"];
    NSDate*date=[dataFormatt dateFromString:(NSString *)[_dataCache objectForKey:BOCeNetworkCacheTime]];
    return [date compare:[NSDate date]] == NSOrderedAscending;
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache {
    [_dataCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}


@end
