//
//  IP_Ctrl5106.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_Ctrl5106 : IPFather

jsonValueInterface(Aeid,        NSString *)
jsonValueInterface(DeviceType,  NSString *)
jsonValueInterface(DeviceID,    NSString *)
jsonValueInterface(VenderID,    NSString *)
jsonValueInterface(Serial,      NSString *)

@end
