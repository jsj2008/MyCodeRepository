//
//  IP_Ctrl5104.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_Ctrl5104 : IPFather

jsonValueInterface(Aeid,        NSString *)
jsonValueInterface(DeviceType,  NSString *)
jsonValueInterface(DeviceID,    NSString *)
jsonValueInterface(VenderID,    NSString *)

@end