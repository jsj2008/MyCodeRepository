//
//  DSStatisticsOrderCell.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsOrderCell.h"
#import "DSStatisticsOrderModel.h"

@interface DSStatisticsOrderCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation DSStatisticsOrderCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.coverImageView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.nameLabel];
    [self cellAddSubView:self.priceLabel];
    [self cellAddSubView:self.statusLabel];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.orderIdLabel];
    [self cellAddSubView:self.timeLabel];
}

- (void)reloadData
{
    if (self.cellData) {
        DSStatisticsOrderModel *model = (DSStatisticsOrderModel*)self.cellData;
        
        [self.coverImageView setOnlineImage:model.cover];
        
        self.titleLabel.text = model.itemName;
        [self.titleLabel sizeToFit];
        
        self.nameLabel.text = model.phone;
        [self.nameLabel sizeToFit];
        
        self.priceLabel.text = model.price;
        [self.priceLabel sizeToFit];
        
        self.orderIdLabel.text = model.orderId;
        [self.orderIdLabel sizeToFit];
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.right = SCREEN_WIDTH -12;
        
        self.statusLabel.text = model.status;
        [self.statusLabel sizeToFit];
        self.statusLabel.right = SCREEN_WIDTH - 12;
        
        if (self.titleLabel.right > self.statusLabel.left - 10) {
            self.titleLabel.width = self.statusLabel.left -  self.titleLabel.left - 10;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 116;
    }
    return height;
}

#pragma mark - Subviews
- (UIImageView*)coverImageView
{
    if (!_coverImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 60, 60)];
        _coverImageView = imageView;
    }
    return _coverImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 38, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel*)priceLabel
{
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 58, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.top = 84;
        _line = view;
    }
    return _line;
}

- (UILabel*)orderIdLabel
{
    if (!_orderIdLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 92, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _orderIdLabel = label;
    }
    return _orderIdLabel;
}

- (UILabel*)statusLabel
{
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 0, 0)];
        label.font = FONT(12);
        _statusLabel = label;
    }
    return _statusLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 92, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _timeLabel = label;
    }
    return _timeLabel;
}
@end
