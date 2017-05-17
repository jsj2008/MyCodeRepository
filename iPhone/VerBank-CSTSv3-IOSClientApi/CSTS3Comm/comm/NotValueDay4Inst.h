//
//  NotValueDay4Inst.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface NotValueDay4Inst : AbstractJsonData
jsonValueInterface(Hdatetime,NSString*)
jsonValueInterface(Instruments ,NSString*)
jsonValueInterface(Description ,NSString*)
jsonValueInterface(HolidayNames,NSString*)
@end
