//
//  QuoteData.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface QuoteData : AbstractJsonData

jsonValueInterface(Instrument,NSString*)

jsonValueInterface(Bid,double)
jsonValueInterface(Ask,double)
jsonValueInterface(QuoteDay,NSString*)
jsonValueInterface(QuoteTime,long long)
jsonValueInterface(OpenPrice,double)
jsonValueInterface(HighPrice,double)
jsonValueInterface(LowPrice ,double)
jsonValueInterface(YclosePrice ,double)
jsonValueInterface(LastBid ,double)
jsonValueInterface(Tradeable, Boolean)
jsonValueInterface(Close,Boolean)

jsonValueInterface(BidBank,NSString*)
jsonValueInterface(BidId ,NSString*)
jsonValueInterface(AskBank,NSString*)
jsonValueInterface(AskId,NSString*)

jsonValueInterface(LastAsk ,double)
jsonValueInterface(BidAmount,double)
jsonValueInterface(AskAmount ,double)
@end
