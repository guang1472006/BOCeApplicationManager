//
//  BOCeNetImageRequest.m
//  Industrial
//
//  Created by boce on 2019/11/26.
//  Copyright © 2019 boce. All rights reserved.
//

#import "BOCeNetImageRequest.h"

@implementation BOCeNetImageRequest

-(NSString *)uploadDate{
    NSDateFormatter *dateFor=[[NSDateFormatter alloc]init];
    [dateFor setDateFormat:@"yyyy-MM-dd"];
    return [dateFor stringFromDate:[NSDate date]];
}

-(id)init{
    if(self=[super init]){
        _enableMark=YES;
        _limitLength=1;
    }
    return self;
}

@end
