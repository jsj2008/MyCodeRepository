//
//  LCRecordTitleCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LDRecordTitleCell.h"

@interface LDRecordTitleCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *operateLabel;
@property (nonatomic, strong) UIView *line;
@end


@implementation LDRecordTitleCell

- (void)drawCell{
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.numberLabel];
    [self cellAddSubView:self.operateLabel];
    [self cellAddSubView:self.line];
    
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 35;
    }
    return height;
}


- (void)reloadData{
    if (self.cellData) {
        
        self.timeLabel.left = 12;
        self.timeLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        
        self.operateLabel.right = SCREEN_WIDTH - 12;
        self.operateLabel.centerY = self.timeLabel.centerY;
        
        self.numberLabel.right = self.operateLabel.left - 40;
        self.numberLabel.centerY = self.timeLabel.centerY;
    }
}

#pragma mark - getters

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(12);
        label.text = @"夺宝时间";
        [label sizeToFit];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(12);
        label.text = @"参与人数";
        [label sizeToFit];
        _numberLabel = label;
    }
    return _numberLabel;
}

- (UILabel *)operateLabel{
    if (!_operateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(12);
        label.text = @"操作";
        [label sizeToFit];
        _operateLabel = label;
    }
    return _operateLabel;
}


- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = 35;
        _line = view;
    }
    return _line;
}

@end
