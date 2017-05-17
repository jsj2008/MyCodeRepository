//
//  CommDocCaptain.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloseOpenUtil.h"
#import "FixUtil.h"
#import "DayUtil.h"
#import "DocUtil.h"
#import "AccountDigestUtil.h"
#import "ExchangeUtil.h"
#import "InterestUtil.h"
#import "GeneralCalculateUtil.h"
#import "SystemDocCaptain.h"
#import "UserDocCaptain.h"
#import "GeneralCheckUtil.h"
#import "InstrumentUtil.h"
#import "PriceSnapShotUtil.h"

@interface CommDocCaptain : NSObject

+ (CommDocCaptain *) getInstance;

- (SystemDocCaptain *)getSystemDocCaptain;
- (UserDocCaptain *)getUserDocCaptain;

- (CloseOpenUtil *)getCloseOpenUtil;
- (FixUtil *)getFixUtil;
- (DayUtil *)getDayUtil;
- (DocUtil *)getDocUtil;
- (AccountDigestUtil *)getAccountDigestUtil;
- (GeneralCalculateUtil *)getGeneralCalculateUtil;
- (ExchangeUtil *)getExchangeUtil;
- (InterestUtil *)getInterestUtil;

- (GeneralCheckUtil *)getGeneralCheckUtil;
- (InstrumentUtil *)getInstrumentUtil:(NSString *)instrument;

//- (PriceSnapShotUtil *)getPriceSnapShotUtil:(CDS_PriceSnapShot *)priceSnapShot;

- (Boolean)isInited;
- (void)setInited:(Boolean)isInited;

- (void)destroy;

@end
