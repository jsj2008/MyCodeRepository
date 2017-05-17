//
//  IP_Ctrl5201.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/28.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_Ctrl5201 : IPFather

jsonValueInterface(Aeid,            NSString *)
jsonValueInterface(DeviceType,      int)
jsonValueInterface(DeviceToken,     NSString *)
jsonValueInterface(AccountID,       NSString *)
jsonValueInterface(GroupName,       NSString *)

@end
