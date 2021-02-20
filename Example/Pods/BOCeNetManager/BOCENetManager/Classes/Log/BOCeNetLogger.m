//
//  BOCeNetLogger.m
//  BOCENetManager
//
//  Created by boce on 2021/1/11.
//

#import "BOCeNetLogger.h"

@implementation BOCeNetLogger

-(NSString *)description{
    return [NSString stringWithFormat:@"当前网络:%ld\n请求URL:%@\n请求参数:%@\n响应:%@",(long)self.status,[NSString stringWithFormat:@"%@/%@",self.request.specName,self.request.url],self.request.parameters,self.response.error];
}


@end
