//
//  PushFromSystem.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/29.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface PushFromSystem : AbstractJsonData

jsonValueInterface(Guid,            NSString *)
jsonValueInterface(Aeid,            NSString *)
jsonValueInterface(Title,           NSString *)
jsonValueInterface(Context,         NSString *)
jsonValueInterface(IsRead,          int)
jsonValueInterface(Time,            NSDate *)
jsonValueInterface(Description,     NSString *)
jsonValueInterface(Account,         long long)

@property NSString *sortTag;

@end
