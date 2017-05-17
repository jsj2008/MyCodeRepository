//
//  SystemConfig.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OpenPositionSortType) {
    OpenPositionSortInstrument = 0,
    OpenPositionSortOpenPrice = 1,
    OpenPositionSortFloatPL = 2,
    OpenPositionSortTradeTime = 3
};

typedef NS_ENUM(NSInteger, OrderSortType) {
    OrderSortInstrument = 0,
    OrderSortDESC = 1,
    OrderSortASC = 2
};

typedef NS_ENUM(NSInteger, PositionSumType) {
    PositionSumSortInstrument = 0,
    PositionSumSortASC = 1
};

@interface ClientSystemConfig : NSObject

+ (ClientSystemConfig *)getInstance;

- (void)saveConfigData;

// 在新增 挂单， 选择默认商品的时候会用到
- (NSString *)getFirstInstrument;
//- (NSArray *)getSortedInstrumentArray;

- (NSArray *)getSelectedInstrumentArray;
- (void)resetInstrumentArray;

@property NSMutableArray *instrumentArray;// ordered
//@property NSMutableArray *unselectInstrumentArray;
@property NSNumber *openPositionSortType;
@property NSNumber *orderSortType;
@property NSNumber *positionSumSortType;
@property NSMutableArray *amountCustomArray;
@property NSMutableArray *columnChooseArray;
@property NSMutableArray *rssResourceArray;

//- (void)setUnselectInstrumentArray:(NSMutableArray *)array;
//- (NSMutableArray *)unselectInstrumentArray;

@end
