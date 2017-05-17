//
//  OperationRecords.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface OperationRecords : AbstractJsonData

jsonValueInterface(Account, long long)
jsonValueInterface(Aeid, NSString *)
jsonValueInterface(Type, int)
jsonValueInterface(SubType, int)
jsonValueInterface(OptTime, NSDate *)
jsonValueInterface(DeviceType, int)

@end
