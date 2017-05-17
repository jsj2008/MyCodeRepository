//
//  APIException.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIException : NSException
{
    NSString *_errCode;
    NSString *_errMessage;
}

-(id)init:(NSString *)errCode errMessage:(NSString *)errMessage;

-(NSString *)getErrCode;

-(void)setErrCode:(NSString *)errCode;

-(NSString *)getErrMessage;

-(void)setErrMessage:(NSString *)errMessage;
@end
