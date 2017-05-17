//
//  CDS_PriceSnapShot.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"
#import "CDS_PriceShift.h"

@interface CDS_PriceSnapShot : CommDocBasicStruct

@property (nonatomic, retain,strong) NSString*         instrumentName;
@property int               digits;
@property long long         accountID;
@property (nonatomic, retain,strong) NSString*         bankName_bid;
@property (nonatomic, retain,strong) NSString*         bankName_ask;
@property (nonatomic, retain,strong) NSString*         quoteID_bid;
@property (nonatomic, retain,strong) NSString*         quoteID_ask;
@property double            basicBid;
@property double            basicAsk;
@property (nonatomic, retain,strong) CDS_PriceShift*   priceShift4Account;
@property (nonatomic, retain,strong) CDS_PriceShift*   priceShift4Group;
@property double            tradePrice;
@property long long         snapshotTime;
@property double            openPrice;
@property double            highPrice;
@property double            lowPrice;
@property double            yClosePrice;
@property double            lastBid;
@property double            lastAsk;
@property (nonatomic, retain,strong) NSString*         quoteDay;
@property Boolean           close;


//- (id)initWithInstrumentName:(NSString *)instrumentName;

- (double)tradePrice:(int)buySell;
- (double)getBid;
- (double)getAsk;
- (double)roundPrice:(double)price;

@end
