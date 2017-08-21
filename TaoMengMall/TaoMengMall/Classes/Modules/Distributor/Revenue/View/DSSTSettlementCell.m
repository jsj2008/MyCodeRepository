//
//  DSSTSettlementCell.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSSTSettlementCell.h"
#import "DSSettlementIncomeModel.h"

@interface DSSTSettlementCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSSTSettlementCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.iconImageView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.priceLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.sumLabel];
    [self cellAddSubView:self.statusLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        DSSettlementIncomeModel *model = (DSSettlementIncomeModel*)self.cellData;
        
        [self.iconImageView setOnlineImage:model.cover];
        
        self.titleLabel.text = model.itemName;
        [self.titleLabel sizeToFit];
        
        
        self.priceLabel.text = model.price;
        [self.priceLabel sizeToFit];
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.left = SCREEN_WIDTH/3;
        
        self.sumLabel.text = model.earning;
        [self.sumLabel sizeToFit];
        self.sumLabel.right = SCREEN_WIDTH - 12;
        
        self.statusLabel.text = self.status;
        [self.statusLabel sizeToFit];
        self.statusLabel.right = SCREEN_WIDTH -12;
        
        if (self.titleLabel.right > self.sumLabel.left-10) {
            self.titleLabel.width = self.sumLabel.left - self.titleLabel.left -10;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 60;
    }
    return height;
}

#pragma mark - Subviews

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 7, 46, 46)];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(64, 8, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)priceLabel
{
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(64, 34, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 34, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel*)sumLabel
{
    if (!_sumLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 0, 0)];
        label.font = FONT(14);
        _sumLabel = label;
    }
    return _sumLabel;
}

- (UILabel*)statusLabel
{
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray100;
        _statusLabel = label;
    }
    return _statusLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 60;
        _line = view;
    }
    return _line;
}
@end
