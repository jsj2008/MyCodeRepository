//
//  QuoteChartManager.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KChartSaveData.h"

typedef NS_ENUM(NSUInteger, ViewName) {
    ViewNameA =0,
    ViewNameB =1,
    ViewNameC =2,
    ViewNameD =3,
};

@interface QuoteChartManager : NSObject

+ (QuoteChartManager *)getInstance;

- (void)saveConfigData;
- (KChartSaveData *)getSaveDataByViewName:(ViewName)viewName instrumentName:(NSString *)instrumentName;

- (NSString *)getInstrumentByViewName:(ViewName)viewName;
- (void)setInstrument:(NSString *)instrument byViewName:(ViewName)viewName;

@end
