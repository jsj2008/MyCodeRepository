//
//  Holidays4ccy.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface Holidays4ccy : AbstractJsonData
jsonValueInterface(Hdatetime,       NSString*)
jsonValueInterface(Currencynames,   NSString*)
jsonValueInterface(Description,     NSString*)
jsonValueInterface(holidayNames,    NSString*)
@end
