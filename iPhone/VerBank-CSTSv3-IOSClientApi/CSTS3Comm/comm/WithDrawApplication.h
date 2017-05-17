//
//  WithDrawApplication.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/28.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface WithDrawApplication : AbstractJsonData

jsonValueInterface(Guid, NSString *)
jsonValueInterface(Type, int)
jsonValueInterface(Account, long long)
jsonValueInterface(Currency, NSString *)
jsonValueInterface(Amount, double)
jsonValueInterface(AppTime, NSDate *)

jsonValueInterface(IpAddress, NSString *)
jsonValueInterface(Description, NSString *)
jsonValueInterface(Dealer, NSString *)
jsonValueInterface(DealerIP, NSString *)
jsonValueInterface(IsRead, int)
jsonValueInterface(ReadTime, NSDate *)

jsonValueInterface(State, int)
jsonValueInterface(CmdType, int)
jsonValueInterface(CmdName, NSString *)
jsonValueInterface(CmdIpAddress, NSString *)
jsonValueInterface(CloseInterest, double)
@end
