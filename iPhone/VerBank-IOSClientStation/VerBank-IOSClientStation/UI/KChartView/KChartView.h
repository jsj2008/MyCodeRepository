//
//  KChartView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const float buttonHeight;

typedef NS_ENUM(NSInteger, ChooseType) {
    CycleChooseType = 0,
    TechnologyType = 1,
    DrawType = 2,
    CandleStickType = 3,
    MaSubArrayType = 4,
};

typedef NS_ENUM(NSInteger, TiArgumentType) {
    MATiArgument = 0
};

@interface KChartView : UIView

//- (void)layoutChange:(UIInterfaceOrientation)rotate;
- (void)reloadHistoricData;
- (void)reset;

- (Boolean)isPoped;

+ (KChartView *)getInstance;

- (void)saveToJsonString:(NSString *)instrumentName ;
- (void)restoreJsonString:(NSString *)instrumentName;

- (void)popKChartViewWithAnimation:(Boolean)animation;
- (void)addKChartViewWithAnimation:(Boolean)animation;

- (void)disableBackButton;
- (void)ableBackButton;

@end
