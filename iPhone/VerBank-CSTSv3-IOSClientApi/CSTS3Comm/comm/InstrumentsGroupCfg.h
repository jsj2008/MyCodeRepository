//
//  InstrumentGroupCfg.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/29.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface InstrumentsGroupCfg : AbstractJsonData
jsonValueInterface(Instrument,NSString*)
jsonValueInterface(GroupName,NSString*)
jsonValueInterface(MinAmount,double)
jsonValueInterface(MaxAmount,double)
jsonValueInterface(Spread2Add,double)
jsonValueInterface(OpenMarginPercentage,double)
jsonValueInterface(MarginCall1Percentage,double)
jsonValueInterface(MarginCall2Percentage,double)
jsonValueInterface(UnLockMarginPercentage,double)
jsonValueInterface(LiquidationMarginPercentage,double)
jsonValueInterface(Tradeable,int)
jsonValueInterface(IsVisable,int)
@end
