//
//  FixUtil_4Trade.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/3.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTrade.h"
#import "CDS_PriceSnapShot.h"

@interface FixUtil_4Trade : NSObject

- (void)fixTrade:(TTrade *)trade
 PriceSnapShot:(CDS_PriceSnapShot *)shot;

- (void)fixTrade:(TTrade *)trade;

@end
