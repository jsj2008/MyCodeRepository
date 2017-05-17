//
//  FixUtil_4Order.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/3.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrder.h"
#import "CDS_PriceSnapShot.h"

@interface FixUtil_4Order : NSObject

- (void)fixOrder:(TOrder *)order  PriceSnapShot:(CDS_PriceSnapShot *)shot;
- (void)fixOrder:(TOrder *)order;

@end
