//
//  BOCeNetRequest.m
//  BOCeNetClient
//
//  Created by boce on 2019/7/18.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeNetRequest.h"

@implementation BOCeNetRequest

-(id)init{
    if(self=[super init]){
        _specName=@"p2c";
        _parameters=@{};
        _enableToken=YES;
        _enableCache=YES;
        _method=BOCEPOST;
        _enableBody=NO;
        _enableMark=NO;
    }
    return self;
}

-(void)setUrl:(NSString *)url{
    _url=url;
    if ([url containsString:@"open"]) {
        _enableToken=NO;
        _enableCache=YES;
    }else if ([url containsString:@"oauth"])
    {
        _enableToken=NO;
        _enableCache=NO;
    }else{
        _enableToken=YES;
        _enableCache=NO;
    }
}

@end
