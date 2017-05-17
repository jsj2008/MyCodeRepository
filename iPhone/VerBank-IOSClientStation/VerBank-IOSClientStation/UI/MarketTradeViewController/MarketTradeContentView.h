//
//  MarketTradeContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketTradeContentView : UIView {
//    UILabel *_accountLabel;
//    UILabel *_instrumentLabel;
//    UILabel *
}

//@property (nonatomic, retain)UILabel *accountLabel;
//@property (nonatomic, retain)UILabel *

- (id)initWithFrame:(CGRect)frame instrument:(NSString *)instrument buySell:(int)buySell;

- (void)addKChartView;
- (void)rotate;
- (void)addListener;
- (void)removeListener;

@end
