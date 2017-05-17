//
//  TiArgumentConfig.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/1.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiDefaultArgument.h"

@interface TiArgumentConfig : NSObject

+ (TiArgumentConfig *)getInstance;

//- (void)saveConfigData;

// ma
//@property NSNumber *maPeriod;
//@property NSNumber *maWidth;
//@property UIColor *maColor;

@property NSMutableArray *maDataArray;

// rsi
@property NSNumber *rsiShortPeriod;
@property NSNumber *rsiShortWidth;
@property UIColor *rsiShortColor;

@property NSNumber *rsiLongPeriod;
@property NSNumber *rsiLongWidth;
@property UIColor *rsiLongColor;

// kdj
@property NSNumber *kdjPeriod;
@property NSNumber *kLineWidth;
@property UIColor *kLineColor;
@property NSNumber *dLineWidth;
@property UIColor *dLineColor;
@property NSNumber *jLineWidth;
@property UIColor *jLineColor;

// macd
@property NSNumber *macdShortPeriod;
@property NSNumber *macdLongPeriod;
@property NSNumber *macdPeriodSignal;
@property NSNumber *macdDiffLineWidth;
@property UIColor  *macdDiffLineColor;
@property NSNumber *macdDemLineWidth;
@property UIColor  *macdDemLineColor;
@property UIColor  *macdPositiveColor;
@property UIColor  *macdNegativeColor;

// Bollinger
@property NSNumber *bollingerBandPeriod;
@property NSNumber *bollingerBandK;
@property NSNumber *bollingerBandLineWidth;
@property UIColor  *bollingerBandLineColor;
@property UIColor  *bollingerBandFillColor;

- (void)reloadData;

@end
