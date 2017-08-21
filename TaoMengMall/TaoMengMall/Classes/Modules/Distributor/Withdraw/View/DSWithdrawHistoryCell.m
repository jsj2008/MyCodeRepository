//
//  DSWithdrawHistoryCell.m
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawHistoryCell.h"
#import "DSWithdrawHistoryModel.h"

@interface DSWithdrawHistoryCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSWithdrawHistoryCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.amountLabel];
    [self cellAddSubView:self.statusLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        DSWithdrawHistoryModel *model = (DSWithdrawHistoryModel*)self.cellData;
        
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        
        self.amountLabel.text = model.amount;
        [self.amountLabel sizeToFit];
        self.amountLabel.right = SCREEN_WIDTH - 12;
        
        self.statusLabel.text = model.status;
        [self.statusLabel sizeToFit];
        self.statusLabel.right = SCREEN_WIDTH - 12;
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
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 34, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray153;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel*)amountLabel
{
    if (!_amountLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 0, 0)];
        label.font = FONT(14);
        _amountLabel = label;
    }
    return _amountLabel;
}

- (UILabel*)statusLabel
{
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 32, 0, 0)];
        label.font = FONT(12);
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
