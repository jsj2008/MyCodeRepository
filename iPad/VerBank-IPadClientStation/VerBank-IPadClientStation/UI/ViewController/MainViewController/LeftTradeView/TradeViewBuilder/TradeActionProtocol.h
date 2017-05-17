//
//  TradeActionProtocol.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

// button tag
typedef NS_ENUM(NSUInteger, OrderTradeType) {
    OrderTradeTypeModify    = 500,
    OrderTradeTypeAdd       = 501,
};

@protocol TradeActionProtocol <NSObject>

- (void)doTrade:(id)sender;
- (void)doDelete;
- (void)doCancel;

@end
