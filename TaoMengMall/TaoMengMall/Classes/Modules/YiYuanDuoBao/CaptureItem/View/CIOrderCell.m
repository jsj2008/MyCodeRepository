//
//  CPOrderCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIOrderCell.h"
#import "CIPayResultModel.h"

@interface CIOrderCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *itemNumberLabel;
@property (nonatomic, strong) UILabel *orderNumberLabel;

@end

@implementation CIOrderCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.itemNumberLabel];
    [self cellAddSubView:self.orderNumberLabel];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        CIPayResultModel *model = cellData;
        height = 70 + [model.itemName sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 24].height;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        
        CIPayResultModel *model = self.cellData;
        
        self.titleLabel.text = model.itemName;
        self.titleLabel.height = [model.itemName sizeWithUIFont:FONT(14) forWidth:SCREEN_WIDTH - 24].height;
        self.titleLabel.width = SCREEN_WIDTH - 24;
        self.titleLabel.top = 12;
        self.titleLabel.left = 8;
        
        self.itemNumberLabel.text = [NSString stringWithFormat:@"商品期号：%@",model.activityId];
        [self.itemNumberLabel  sizeToFit];
        self.itemNumberLabel.top = self.titleLabel.bottom + 12;
        self.itemNumberLabel.left = 8;
        
        self.orderNumberLabel.text = [NSString stringWithFormat:@"夺宝号码：%@",model.numbers];
        [self.orderNumberLabel sizeToFit];
        self.orderNumberLabel.width = SCREEN_WIDTH - 16;
        self.orderNumberLabel.top = self.itemNumberLabel.bottom + 4;
        self.orderNumberLabel.left = 8;
    }
}

#pragma mark - getters

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(14);
        label.numberOfLines = 0;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)itemNumberLabel{
    if (!_itemNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(12);
        _itemNumberLabel = label;
    }
    return _itemNumberLabel;
}

- (UILabel *)orderNumberLabel{
    if (!_orderNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(12);
        _orderNumberLabel = label;
    }
    return _orderNumberLabel;
}


@end
