//
//  QuoteChartLayoutCenter.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/7.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KChartWebView.h"

#define NormalScreenStatus -1

@interface QuoteChartLayoutCenter : NSObject

@property NSMutableArray *kChartViewArray;
@property UIView *kChartSuperView;

//@property KChartWebView *kChartViewA;
//@property KChartWebView *kChartViewB;
//@property KChartWebView *kChartViewC;
//@property KChartWebView *kChartViewD;

- (void)updateContraints:(NSUInteger)index;

- (NSUInteger)getIndexOfKchartView:(KChartWebView *)view;

@end
