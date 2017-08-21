//
//  DSRevenueDetailCell.m
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRevenueDetailTotalCell.h"
#import "DSRevenueDetailModel.h"

@interface DSRevenueDetailTotalCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *revenueLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation DSRevenueDetailTotalCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.revenueLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        DSRevenueDetailModel *model = (DSRevenueDetailModel*)self.cellData;
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.centerY = 22;

        self.revenueLabel.text = model.amount;
        [self.revenueLabel sizeToFit];
        self.revenueLabel.centerY = 22;
        self.revenueLabel.right = SCREEN_WIDTH - 12;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 44;
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

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 44;
        _line = view;
    }
    return _line;
}
@end
