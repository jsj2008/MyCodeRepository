//
//  PMPointDetailCell.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "PMPointDetailCell.h"
#import "PointDetailUsesListModel.h"

@interface PMPointDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation PMPointDetailCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.valueLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
    if (self.cellData) {
        PointDetailUsesListModel *model = self.cellData;
        self.titleLabel.text = model.desc;
        self.timeLabel.text = model.time;
        self.valueLabel.text = model.amount;
        if ([model.amount integerValue] >= 0) {
            self.valueLabel.textColor = Theme_Color;
        }else {
            self.valueLabel.textColor = RGB(157, 195, 63);
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 69;
    }
    return height;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(10, 68, SCREEN_WIDTH-20, LINE_WIDTH)];
        _line.backgroundColor = [UIColor grayColor];
        _line.alpha = 0.3;
    }
    return _line;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 25)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"";
        _titleLabel.font = FONT(13);
        _titleLabel.textColor = Color_Gray100;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 25)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.text = @"";
        _timeLabel.font = FONT(13);
        _timeLabel.textColor = Color_Gray153;
    }
    return _timeLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 26, SCREEN_WIDTH-20, 25)];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.text = @"";
        _valueLabel.font = FONT(16);
        _valueLabel.textColor = RGB(252, 107, 7);
    }
    return _valueLabel;
}
@end
