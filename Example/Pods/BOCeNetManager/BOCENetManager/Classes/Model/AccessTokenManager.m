//
//  AccessTokenManager.m
//  p2c_iOS
//
//  Created by 张文学 on 2020/9/5.
//  Copyright © 2020 天津渤海商品交易所. All rights reserved.
//

#import "AccessTokenManager.h"

@implementation AccessTokenManager

+ (AccessTokenManager *)sharedManager{
    static AccessTokenManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)CacheTokenModel:(AccessTokenModel *)model{
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:model forKey:@"AccessToken"];
    
    // 归档结束.
    [archiver finishEncoding];
    
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tokenManager"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]){
        if (model==nil){
            [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
        }else{
            [data writeToFile:file atomically:YES];
        }
    }else{
        [data writeToFile:file atomically:YES];
    }
}

-(AccessTokenModel *)tokenWithEnCode{
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tokenManager"];
    
    // data.
    NSData *data = [NSData dataWithContentsOfFile:file];
    
    // 反归档.
    NSKeyedUnarchiver *unarchiver=nil;
    
    if (data!=nil) {
        // 反归档.
        unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    }
    
    // 获取@"model" 所对应的数据
    return  [unarchiver decodeObjectForKey:@"AccessToken"];
}

@end
