//
//  OrderHisTableViewCell.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/10.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OrderHisTableViewContentCell.h"

@implementation OrderHisTableViewContentCell

@synthesize typeLabel;  // 類型

@synthesize limitPriceLabel;
@synthesize stopPriceLabel;
@synthesize stopMoveLabel;
@synthesize dealPriceLabel; // 成交價
@synthesize IFDLimitPriceTLabel;
@synthesize IFDStopPriceTLabel;

@synthesize categoryLabel; // 類別
@synthesize closeTicketLabel; // 指定平倉單號

@synthesize valueTimeTypeLabel; // 有效日期类型
@synthesize valueTimeEndLabel; // 有效期至
@synthesize confirmTimeLabel; // 确认时间
@synthesize inputTimeLabel; // 输入时间

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
