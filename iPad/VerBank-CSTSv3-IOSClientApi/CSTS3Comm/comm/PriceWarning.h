//
//  PriceWarning.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface PriceWarning : AbstractJsonData
jsonValueInterface(Guid, NSString*)
jsonValueInterface(Account,long long)
jsonValueInterface(DealerName, NSString*)

jsonValueInterface(DealerDesc, NSString*)

jsonValueInterface(Origin,int)
jsonValueInterface(Time,NSDate*)
jsonValueInterface(Instrument, NSString*)
jsonValueInterface(Price,double)
//jsonValueInterface(CompareWay,int)
jsonValueInterface(PriceType,int)
jsonValueInterface(IsPriceReach,int)
jsonValueInterface(ReachPrice,double)
jsonValueInterface(ReachTime,NSDate*)
jsonValueInterface(IsRead,int)
jsonValueInterface(ReadTime,NSDate*)
jsonValueInterface(ReadDescription, NSString*)

jsonValueInterface(ExpiryType, int)
jsonValueInterface(ExpiryTime, NSDate*)

@end
