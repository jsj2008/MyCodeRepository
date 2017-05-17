//
//  Info_TRADESERV1013.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"

#import "MarginCall.h"

@interface Info_TRADESERV1013 : InfoFather

jsonValueInterface(AccountID,   long long)
jsonValueInterface(MarginCall,  MarginCall *)

@end
