//
//  GeneralCalculateUtil.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CDS_LongShotPair.h"

@interface GeneralCalculateUtil : NSObject

- (CDS_LongShotPair *)calculateLongShortInstrument:(NSString *)instrument
                                           buySell:(int)buySell
                                            amount:(double)amount
                                             price:(double)price;

- (CDS_LongShotPair *)calculateLongShortCCy1:(NSString *)ccy1
                                        ccy2:(NSString *)ccy2
                                     buysell:(int)buysell
                                      amount:(double)amount
                                       price:(double)price;

@end
