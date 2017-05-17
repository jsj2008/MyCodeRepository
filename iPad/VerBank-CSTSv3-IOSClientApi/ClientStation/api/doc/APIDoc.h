//
//  APIDoc.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommDocCaptain.h"
#import "CloseOpenUtil.h"

@interface APIDoc : NSObject

+ (CloseOpenUtil *)getCloseOpenUtil;
+ (DayUtil *)getDayUtil;
+ (ExchangeUtil *)getExchangeUtil;
+ (FixUtil *) getFixUtil;
+ (GeneralCalculateUtil *) getGeneralCalculateUtil;
+ (InstrumentUtil *) getInstrumentUtil:(NSString *) instrument;
//+ (PriceSnapShotUtil *)getPriceSnapShotUtil:(CDS_PriceSnapShot *)priceSnapShot;
+ (SystemDocCaptain *)getSystemDocCaptain;
+ (UserDocCaptain *)getUserDocCaptain;
+ (AccountDigestUtil *)getAccountDigestUtil;
+ (Boolean)isInited;
+ (void)setInited:(Boolean)inited;
+ (DocUtil *)getDocUtil;
+ (GeneralCheckUtil *)getGeneralCheckUtil;
+ (InterestUtil *)getInterestUtil;

@end
