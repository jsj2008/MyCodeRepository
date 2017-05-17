//
//  IP_Ctrl1001.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/23.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "IPFather.h"

@interface IP_Ctrl1001 : IPFather

-(id)           init;

jsonValueInterface(Password,        NSString *)
jsonValueInterface(IsFirstLogin,    Boolean)
jsonValueInterface(FirstLoginTime,  long long)
jsonValueInterface(IPAddress,       NSString*)
jsonValueInterface(Aeid,            NSString*)
jsonValueInterface(ClientID,        NSString *)
jsonValueInterface(Version,         NSString *)

@end
