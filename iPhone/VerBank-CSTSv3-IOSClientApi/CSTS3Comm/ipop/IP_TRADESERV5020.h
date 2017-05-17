//
//  IP_TRADESERV5020.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5020 : IPFather

jsonValueInterface(Instrument, NSString *)
jsonValueInterface(IsToQuerryAll, Boolean)
jsonValueInterface(GroupName, NSString *)

@end
