//
//  MarginCall.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface MarginCall : AbstractJsonData

jsonValueInterface(Account, long long)
jsonValueInterface(TradeDay, NSString*)
jsonValueInterface(MarginCalllevel,int)
jsonValueInterface(CallTime, NSDate*)
jsonValueInterface(MarginPerc,double)
jsonValueInterface(IsUserConfirm,int)
jsonValueInterface(DealerConfirmStream, NSString*)
jsonValueInterface(SubLevel,int)
@end
