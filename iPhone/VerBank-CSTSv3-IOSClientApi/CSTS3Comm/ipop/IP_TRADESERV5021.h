//
//  IP_TRADESERV5021.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5021 : IPFather

jsonValueInterface(AccountID, long long)
jsonValueInterface(InstrumentName, NSString *)
jsonValueInterface(IsToQueryAll, Boolean)

@end
