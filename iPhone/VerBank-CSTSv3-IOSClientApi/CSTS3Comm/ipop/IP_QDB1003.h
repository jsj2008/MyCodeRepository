//
//  IP_QDB1003.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_QDB1003 : IPFather

jsonValueInterface(Instrument, NSString *)
jsonValueInterface(Cycle, int)
jsonValueInterface(Limit, int)
jsonValueInterface(EndTime, long long)

@end
