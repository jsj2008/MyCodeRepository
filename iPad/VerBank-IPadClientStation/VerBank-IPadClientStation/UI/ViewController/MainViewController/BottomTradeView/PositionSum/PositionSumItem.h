//
//  PositionSumItem.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionSumItem : NSObject

@property NSString *instrument;
@property double sumAmount;
@property double sumFloatPL;

@property NSString *tradeDir;
@property NSString *buySellSymbol;

@property double sellAmount;
@property double sellAvg;
@property double sellFloatPL;

@property double buyAmount;
@property double buyAvg;
@property double buyFloatPL;

@property NSString *sortTag;

@end
