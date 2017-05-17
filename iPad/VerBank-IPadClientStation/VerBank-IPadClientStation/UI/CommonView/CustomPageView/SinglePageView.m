//
//  SinglePageView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "SinglePageView.h"
#import "CustomPageView.h"
#import "LangCaptain.h"
#import "OperationRecordsSave.h"
#import "OptRecordTable.h"
#import "JumpDataCenter.h"
#import "LayoutCenter.h"
#import "ClientSystemConfig.h"
#import "MTP4CommDataInterface.h"

@interface SinglePageView() {
    NSString *_title;
    UIButton *addButton;
}

@end

@implementation SinglePageView

@synthesize title = _title;
@synthesize pageIndex;

@synthesize titleButton;

- (id)init {
    if (self = [super init]) {
        titleButton = [[UIButton alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        titleButton = [[UIButton alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        titleButton = [[UIButton alloc] init];
    }
    return self;
}

// 和resetView 不同 并不是 每个View 都需要update 所以自己实现
- (void)updateView {
    NSLog(@"SinglePageView updateView");
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [titleButton setTitle:title forState:UIControlStateNormal];
    
    // 不應該這麼寫， 嚴重破壞代碼結構， 暫時先這麼寫
    if ([title isEqualToString:[[LangCaptain getInstance] getLangByCode:@"OrderPosition"]]) {
        addButton = [[UIButton alloc] init];
        [addButton setFrame:CGRectMake(0, 0, 30, 30)];
//        [addButton setCenter:titleButton.center];
        [addButton setImage:[UIImage imageNamed:@"images/arrow/addOrder.png"] forState:UIControlStateNormal];
        [titleButton addSubview:addButton];
        [addButton addTarget:self action:@selector(addOrder) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addOrder {
    [[OperationRecordsSave getInstance] addOpeRecords:APP_OPT_TYPE_PRICE subType:APP_OPT_TYPE_PRICE_ITEM_1];
    
//    NSIndexPath *indexPath = [self getSelectIndexByEvent:event];
//    NSString *instrumentName = [[contentArray objectAtIndex:[indexPath row]] instrument];
    NSArray *instrumentArray = [[ClientSystemConfig getInstance] getSelectedInstrumentArray];

    
    [[JumpDataCenter getInstance] setCreateTradeInstrument:[instrumentArray objectAtIndex:0]];
    [[JumpDataCenter getInstance] setMarketTradeType:SELL];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] leftContentView] didClickAtFunction:Function_Left_AddOrderTrade];
    [[[[LayoutCenter getInstance] mainViewLayoutCenter] rightContentView] reloadQuoteDataWithInstrument:[instrumentArray objectAtIndex:0]];
    [[[LayoutCenter getInstance] quoteChartLayoutCenter] updateContraints:0];
}

// 用于重新载入数据
// 需要 载入 报表数据的地方重写， 一般 可以不重写
- (void)reloadPageData {
    NSLog(@"this thi SinglePageView reloadData");
}

- (void)pageSelect {
    NSLog(@"this thi SinglePageView pageSelect");
}

- (void)pageUnSelect {
    NSLog(@"this thi SinglePageView pageUnSelect");
}

- (void)addListener {
    NSLog(@"this thi SinglePageView addListener");
}

- (void)removeListener {
    NSLog(@"this thi SinglePageView removeListener");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [addButton setFrame:CGRectMake(titleButton.bounds.size.width / 2 + 20.0f, titleButton.bounds.size.height / 2 - 15.0f, 30, 30)];
}

// 子类不要实现
- (void)dealloc {
    [self removeListener];
}

@end
