//
//  TradeResult_OrderCFD.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrder.h"

@interface TradeResult_OrderCFD : NSObject

@property int result;
@property NSString *_errMessage;
@property TOrder *order;

- (NSString *)getErrCode;
- (void)setErrCodeAndCreateResult:(NSString *)code;

@end
