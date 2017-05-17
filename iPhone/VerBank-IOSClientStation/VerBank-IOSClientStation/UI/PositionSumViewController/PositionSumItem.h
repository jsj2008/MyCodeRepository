//
//  PositionSumItem.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionSumItem : NSObject

@property NSString *instrument;
@property double sumAmount;
@property double sumFloatPL;

@property NSString *tradeDir;

@property NSString *sell;
@property double sellAmount;
@property double sellAvg;
@property double sellFloatPL;

@property NSString *buy;
@property double buyAmount;
@property double buyAvg;
@property double buyFloatPL;

@property NSString *sortTag;

@end
