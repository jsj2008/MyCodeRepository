//
//  APIException.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "APIException.h"

@implementation APIException


-(id)init:(NSString *)errCode errMessage:(NSString *)errMessage{
    if (self=[super init]) {
        _errCode=errCode;
        _errMessage=errMessage;
    }
    return self;
}

-(NSString *)getErrCode{
    return _errCode;
}

-(void)setErrCode:(NSString *)errCode{
    _errCode=errCode;
}

-(NSString *)getErrMessage
{
    return _errMessage;
}

-(void)setErrMessage:(NSString *)errMessage{
    _errMessage=errMessage;
}

@end
