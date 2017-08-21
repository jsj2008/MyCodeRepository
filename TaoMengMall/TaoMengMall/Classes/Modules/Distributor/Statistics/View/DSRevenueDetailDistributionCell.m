//
//  DSRevenueDetailDistributionCell.m
//  CarKeeper
//
//  Created by marco on 3/3/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRevenueDetailDistributionCell.h"
#import "DSRevenueDetailModel.h"

@interface DSRevenueDetailDistributionCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *revenueLabel;
@property (nonatomic, strong) UILabel *profitLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation DSRevenueDetailDistributionCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.revenueLabel];
    [self cellAddSubView:self.profitLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        DSRevenueDetailModel *model = (DSRevenueDetailModel*)self.cellData;
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.centerY = 30;
        
        self.revenueLabel.text = model.amount;
        [self.revenueLabel sizeToFit];
        self.revenueLabel.top = 10;
        self.revenueLabel.right = SCREEN_WIDTH - 12;
        
        self.profitLabel.text = model.earning;
        [self.profitLabel sizeToFit];
        self.profitLabel.top = 37;
        self.profitLabel.right = SCREEN_WIDTH - 12;
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
- (UILabel*)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel*)revenueLabel
{
    if (!_revenueLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _revenueLabel = label;
    }
    return _revenueLabel;
}

- (UILabel*)profitLabel
{
    if (!_profitLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray153;
        _profitLabel = label;
    }
    return _profitLabel;
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
