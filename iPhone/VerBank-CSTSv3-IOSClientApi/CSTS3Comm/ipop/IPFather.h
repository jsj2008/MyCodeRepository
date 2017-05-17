//
//  IPFather.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/6.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AbstractJsonData.h"

@interface IPFather : AbstractJsonData

+(NSString *)   getIpFatherId;

-(id)           init;

-(NSString *)   getID;

-(NSString *)   getOperateId;

-(NSString *)   getUserName;

-(void)         setUserName:(NSString *)userName;

-(long long)    getCreateTime;

-(NSString *) getSignature;

-(void) setSignature:(NSString *)signature;

-(NSString *) getOriSignature;
-(void) setOriSignature:(NSString *)oriSignature;

- (NSString *)toString;

@end
