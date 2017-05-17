//
//  IP_TADESERV6102.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/1/28.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_REPORT6102 : IPFather

jsonValueInterface(Aeid,            NSString *)
jsonValueInterface(FromTime,        NSDate *)
jsonValueInterface(EndTime,         NSDate *)

@end
