//
//  OPFather.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/6.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AbstractJsonData.h"
#import "IPFather.h"

@interface OPFather : AbstractJsonData

-(id)           init;
-(id)           initWithIp:(IPFather *)ip;

-(NSString *)   getID;
-(NSString *)   getOperateId;
-(NSString *)   getErrCode;
-(NSString *)   getErrMessage;

-(void)         setErrCode:(NSString *)errCode;
-(void)         setErrMessage:(NSString *)errMessage;

-(Boolean)      isSuccessed;
-(void)         setSuccess:(Boolean)successed;

-(int)          getUsedTime;
-(void)         setUsedTime:(int)usedTime;

@end
