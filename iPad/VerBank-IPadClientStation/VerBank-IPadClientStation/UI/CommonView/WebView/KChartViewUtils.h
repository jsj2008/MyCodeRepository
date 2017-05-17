//
//  QuoteUtils.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KChartParamDefine.h"

@interface KChartViewUtils : NSObject

+ (NSString *)queryHistoricData:(NSString *)insrtument cycle:(int)cycle;

+ (NSString *)getKChartCycleInputValue:(ChartCycleType)cycle;

+ (int)getCycleValueByType:(ChartCycleType)typeDefine;


+ (NSDictionary *)parseParam:(NSString *)argumentConfig;

@end
