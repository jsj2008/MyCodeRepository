//
//  InstrumentUtil.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Instrument.h"
#import "CDS_PriceShift.h"
#import "CDS_PriceSnapShot.h"
#import "SystemDocCaptain.h"
#import "UserDocCaptain.h"

@interface InstrumentUtil : NSObject

//- (id)initWithInstrument:(Instrument *)instrument
//        SystemDocCaptain:(SystemDocCaptain *)systemDocCaptain
//          UserDocCaptain:(UserDocCaptain *)userDocCaptain;

- (id)initWithInstrument:(Instrument *)instrument;

- (double)getOnePointPrice;
- (NSString *)formatClientPrice:(double)price;
- (NSString *)formatClientPrice:(double)price isFloor:(Boolean)isFloor;
- (Instrument *)getInstrumentNode;
- (CDS_PriceShift *)getPriceShift4AccountWithAccountID:(long long)accountID;
- (CDS_PriceShift *)getPriceShift4GroupWithGroupName:(NSString *)groupName;
//- (CDS_PriceSnapShot *)getPriceSnapShot;
- (CDS_PriceSnapShot *)getPriceSnapShotWithAccountID:(long long)accountID;
- (CDS_PriceSnapShot *)getPriceSnapShot4GivenPriceWitBid:(double)bid  Ask:(double)ask;
- (CDS_PriceSnapShot *)getPriceSnapShot4GivenPriceWithAccountID:(long long)accountID  Bid:(double)bid  Ask:(double)ask;
- (int)getOrderTradeCostWithAccountID:(long long)accountID;
- (NSString *)getInstrumentName;

@end
