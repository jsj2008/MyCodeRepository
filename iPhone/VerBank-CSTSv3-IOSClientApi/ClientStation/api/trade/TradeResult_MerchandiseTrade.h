//
//  TradeResult_MerchandiseTrade.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeResult_MerchandiseTrade : NSObject

@property int result;
@property NSString * _errMessage;

- (NSString *)getErrCode;
- (void)setErrCodeAndCreateResult:(NSString *)code;

@end
