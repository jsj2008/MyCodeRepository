//
//  MessageToAccount.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface MessageToAccount : AbstractJsonData

jsonValueInterface(Guid,NSString*)
jsonValueInterface(Dealer,NSString*)
jsonValueInterface(Time,NSDate*)
jsonValueInterface(Title,NSString*)
jsonValueInterface(Context, NSString*)
jsonValueInterface(Type,int)
jsonValueInterface(Target, NSString*)
jsonValueInterface(MessageType,int)
jsonValueInterface(IsRead,int)

@property NSString *    sortTag;

@end
