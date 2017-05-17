//
//  OperationRecords.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OperationRecords.h"

static NSString * jsonId = @"OperationRecords";

static NSString * account = @"1";
static NSString * aeid = @"2";
static NSString * type = @"3";
static NSString * subType = @"4";
static NSString * optTime = @"5";
static NSString * deviceType = @"6";

@implementation OperationRecords

- (id)init {
    if(self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionLongLong(Account, account)
jsonImplementionString(Aeid, aeid)
jsonImplementionInt(Type, type)
jsonImplementionInt(SubType, subType)
jsonImplementionDate(OptTime, optTime)
jsonImplementionInt(DeviceType, deviceType)

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:jsonId forKey:@"jsonId"];
    [aCoder encodeObject:[NSNumber numberWithLongLong:[self getAccount]] forKey:@"account"];
    [aCoder encodeObject:[self getAeid] forKey:@"aeid"];
    [aCoder encodeObject:[NSNumber numberWithInt:[self getType]] forKey:@"type"];
    [aCoder encodeObject:[NSNumber numberWithInt:[self getSubType]] forKey:@"subType"];
    [aCoder encodeObject:[self getOptTime] forKey:@"optTime"];
    [aCoder encodeObject:[NSNumber numberWithInt:[self getDeviceType]] forKey:@"deviceType"];
}

//将对象解码(反序列化)
-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        [self setEntry:@"jsonId" entry:jsonId];
        [self setAccount:[[aDecoder decodeObjectForKey:@"account"] longLongValue]];
        [self setAeid:[aDecoder decodeObjectForKey:@"aeid"]];
        [self setType:[[aDecoder decodeObjectForKey:@"type"] intValue]];
        [self setSubType:[[aDecoder decodeObjectForKey:@"subType"] intValue]];
        [self setOptTime:[aDecoder decodeObjectForKey:@"optTime"]];
        [self setDeviceType:[[aDecoder decodeObjectForKey:@"deviceType"] intValue]];
    }
    return (self);
}


@end
