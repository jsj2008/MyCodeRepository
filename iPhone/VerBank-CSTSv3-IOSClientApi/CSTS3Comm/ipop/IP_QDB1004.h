//
//  IP_QBD1004.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_QDB1004 : IPFather

jsonValueInterface(Instrument, NSString *)
jsonValueInterface(Today, Boolean)
jsonValueInterface(Limit, int)

@end
