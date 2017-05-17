//
//  TradeResult_CAURL.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeResult_CAURL : NSObject

@property Boolean succeed;
@property NSString *_errCode;
@property NSString *_errMessage;
@property NSString *caURL;

@end
