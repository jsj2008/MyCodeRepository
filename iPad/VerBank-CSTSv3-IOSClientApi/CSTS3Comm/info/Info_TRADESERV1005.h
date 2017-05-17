//
//  Info_TRADESERV1005.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"

const static int ATTRID_USERLOGIN = 0;
const static int ATTRID_ACCOUNTSTRATEGY = 1;
const static int ATTRID_INSTRUMENTCFG4GROUP = 2;
const static int ATTRID_INSTRUMENTCFG4ACCOUNT = 3;
const static int ATTRID_ACCOUNT_DELETE = 4;
const static int ATTRID_USER_DELETED = 5;
const static int ATTRID_USER_RELOAD = 6;

@interface Info_TRADESERV1005 : InfoFather

jsonValueInterface(ChangedAttrID,   int)
jsonValueInterface(GroupName,       NSString *)
jsonValueInterface(AccountID,       long long)
jsonValueInterface(InstrumentName,  NSString *)

@end
