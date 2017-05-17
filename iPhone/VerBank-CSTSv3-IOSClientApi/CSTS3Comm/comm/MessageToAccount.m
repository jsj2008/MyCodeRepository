//
//  MessageToAccount.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "MessageToAccount.h"
// private String Dealer;
// private Date Time;
// private String Title;
// private byte[] Context;
// private int Type;
// private String target;
// private int messageType;
// private int isRead;

static NSString * jsonId = @"MessageToAccount";

static NSString * guid = @"1";
static NSString * dealer = @"2";
static NSString * Time = @"3";
static NSString * title = @"4";
static NSString * context = @"5";
static NSString * type = @"6";
static NSString * target = @"7";
static NSString * messageType = @"8";
static NSString * isRead = @"9";

@implementation MessageToAccount

@synthesize sortTag;

- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
jsonImplementionString(Guid,        guid)
jsonImplementionString(Dealer,      dealer)
jsonImplementionDate(Time,        Time)
jsonImplementionString(Title,       title)
jsonImplementionString(Context,     context)
jsonImplementionInt(Type,           type)
jsonImplementionString(Target,      target)
jsonImplementionInt(MessageType,    messageType)
jsonImplementionInt(IsRead,         isRead)
@end
