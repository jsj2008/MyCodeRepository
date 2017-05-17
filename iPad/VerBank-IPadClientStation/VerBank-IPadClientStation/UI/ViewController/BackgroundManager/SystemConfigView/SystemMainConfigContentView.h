//
//  SystemMainConfigContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutContentView.h"

typedef NS_ENUM(NSInteger, SectionName) {
    // 系统设定栏位
    CurrencyChoose      = 0,
    PasswordChange      = 1,
    Certificate         = 2,
    PhonePinChange      = 3, // 电话下单密码
    OpenPositionSort    = 4,
    OrderSort           = 5,
    PositionSumSort     = 6,
    AmountCustom        = 7,
    QuoteListUpDownType = 8,
    //    ColumnChoose        = 8,
    Rss                 = 9,
    KChartNumber        = 10,
    
    
};

static const CGFloat titleLabelHeight          = 50.0f;
static const CGFloat contentTableViewCellHeight= 42.0f;

@interface SystemMainConfigContentView : LayoutContentView

@property IBOutlet UILabel *titleLabel;
@property IBOutlet UITableView *contentTableView;

@end
