//
//  IP_Ctrl4002.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_Ctrl4002 : IPFather

jsonValueInterface(Aeid,        NSString *)
jsonValueInterface(Account,     long long)
jsonValueInterface(OldPhonePin, NSString *)
jsonValueInterface(NewPhonePin, NSString *)
jsonValueInterface(RealName,    NSString *)
jsonValueInterface(IpAddress,   NSString *)

@end
