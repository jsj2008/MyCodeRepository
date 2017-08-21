//
//  LCInfoCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LDInfoCell.h"
#import "LRDetailResultModel.h"

@interface LDInfoCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *luckyNumberLabel;
@property (nonatomic, strong) UILabel *luckyValueLabel;

@end

@implementation LDInfoCell

- (void)drawCell{
    self.backgroundColor = RGB(242, 237, 237);
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.numberLabel];
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.luckyNumberLabel];
    [self cellAddSubView:self.luckyValueLabel];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        LRDetailResultModel *model = cellData;
        height = 104 + [model.itemName sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH-24].height;
        //height = 120;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        LRDetailResultModel *model = self.cellData;
        
        self.titleLabel.text = model.itemName;
        self.titleLabel.left = 12;
        self.titleLabel.top = 12;
        //[self.titleLabel sizeToFit];
        self.titleLabel.width = SCREEN_WIDTH - 24;
        self.titleLabel.height = [model.itemName sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH-24].height;
        
        self.numberLabel.text = [NSString stringWithFormat:@"期号：%@",model.activityId];
        [self.numberLabel sizeToFit];
        self.numberLabel.top = self.titleLabel.bottom + 12;
        self.numberLabel.left = self.titleLabel.left;
        
        self.timeLabel.text = [NSString stringWithFormat:@"揭晓时间：%@",model.announceTime];
        [self.timeLabel sizeToFit];
        self.timeLabel.top = self.numberLabel.bottom + 8;
        self.timeLabel.left = self.titleLabel.left;
        
        self.luckyNumberLabel.text = @"本期幸运号码";
        [self.luckyNumberLabel sizeToFit];
        self.luckyNumberLabel.top = self.timeLabel.bottom + 8;
        self.luckyNumberLabel.left = self.titleLabel.left;
        
        if (model.luckyNumber) {
            self.luckyValueLabel.text = model.luckyNumber;
        }else{
            self.luckyValueLabel.text = @"未开奖";
        }
        
        [self.luckyValueLabel sizeToFit];
        self.luckyValueLabel.centerY = self.luckyNumberLabel.centerY;
        self.luckyValueLabel.left = self.luckyNumberLabel.right;
    }
}

#pragma mark - getters

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        label.numberOfLines = 0;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _numberLabel = label;
    }
    return _numberLabel;
}

- (UILabel *)luckyNumberLabel{
    if (!_luckyNumberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _luckyNumberLabel = label;
    }
    return _luckyNumberLabel;
}

- (UILabel *)luckyValueLabel{
    if (!_luckyValueLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(233, 89, 101);
        label.font = FONT(14);
        _luckyValueLabel = label;
    }
    return _luckyValueLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _timeLabel = label;
    }
    return _timeLabel;
}
@end
