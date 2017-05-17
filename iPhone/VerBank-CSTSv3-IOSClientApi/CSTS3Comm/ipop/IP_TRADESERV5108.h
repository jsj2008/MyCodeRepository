//
//  IP_TRADESERV5108.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

@interface IP_TRADESERV5108 : IPFather

jsonValueInterface(OrderID, long long)
jsonValueInterface(AccountID, long long)
jsonValueInterface(StopMove, int)

@end
