//
//  IP_Ctrl4004.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/13.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_Ctrl4004 : IPFather

jsonValueInterface(Aeid,        NSString *)
jsonValueInterface(Account,     long long)
jsonValueInterface(PhonePin,    NSString *)

@end
