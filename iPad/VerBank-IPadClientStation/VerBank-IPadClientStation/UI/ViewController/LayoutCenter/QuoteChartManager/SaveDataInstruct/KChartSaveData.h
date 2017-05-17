//
//  KChartSaveData.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KChartParamDefine.h"
#import "TiArgumentConfig.h"

@interface KChartSaveData : NSObject

@property NSString          *instrumentName;
//@property ChartCycleType    cycleType;          // 週期
//@property KChartType        kChartType;         // 蠟燭線類型
//@property NSMutableArray    *technologyArray;   // 技術指標 隊列
//@property NSMutableArray    *maTechnologyArray; // ma 指標 隊列

@property NSMutableArray    *technologyNameArray;
@property NSMutableArray    *maNameArray;
@property ChartCycleType    chartCycleType;
@property NSString          *chartType;
@property TiArgumentConfig  *tiArgumentConfig;

@property NSString          *isOrderLineDraw;
@property NSMutableArray    *orderLineCUIDArray;

@property NSMutableDictionary *tiDictionary; // 从 web 里读取得 技术指标的 配置

//@property TiArgumentConfig  *tiArgumentConfig;

@property NSString          *tiJsonString;

//- (NSArray *)getTechnologyNameArray;
//- (NSArray *)getMaNameArray;
//- (ChartCycleType)getChartCycleType;
//- (NSString *)getChartType;
//
////- (NSArray *)getMaParamArray;
//- (TiArgumentConfig *)getTiArgumentConfig;

@end
