//
//  TradeResult_HedgeCFD.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrderHis.h"

@interface TradeResult_HedgeCFD : NSObject

@property int result;
@property NSString *_errMessage;
@property TOrderHis *orderHis;

- (void)setErrCodeAndCreateResult:(NSString *)code;
- (NSString *)getErrCode;

@end
