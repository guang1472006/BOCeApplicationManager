//
//  BOCeNetManager+Aspect.m
//  p2c_iOS
//
//  Created by 张文学 on 2020/9/5.
//  Copyright © 2020 天津渤海商品交易所. All rights reserved.
//

#import "BOCeNetManager+Aspect.h"

@implementation BOCeNetManager (Aspect)

+(void)load{
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(){
        for (NSURLSessionTask *task in [BOCeNetManager shareManager].sessionManager.dataTasks) {
            if(task.state==NSURLSessionTaskStateRunning){
                [task cancel];
            }
        }
    }error:nil];
}

@end
