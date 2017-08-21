//
//  LCRecordContentCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LDRecordContentCell.h"
#import "LRDetailRecordModel.h"


@interface LDRecordContentCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *numberDescLabel;
@property (nonatomic, strong) UILabel *operateLabel;
@property (nonatomic, strong) UIView *line;
@end


@implementation LDRecordContentCell

- (void)drawCell{
    [self cellAddSubView:self.timeLabel];
    [self cellAddSubView:self.numberLabel];
    [self cellAddSubView:self.numberDescLabel];
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
        LRDetailRecordModel *model = self.cellData;
        
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.left = 12;
        self.timeLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        
        self.operateLabel.right = SCREEN_WIDTH - 12;
        self.operateLabel.centerY = self.timeLabel.centerY;
        
        self.numberDescLabel.right = self.operateLabel.left - 30;
        self.numberDescLabel.centerY = self.timeLabel.centerY;
        
        self.numberLabel.text = model.amount;
        [self.numberLabel sizeToFit];
        self.numberLabel.right = self.numberDescLabel.left;
        self.numberLabel.centerY = self.numberDescLabel.centerY;
        
    }
}

#pragma mark - getters

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(233, 89, 101);
        label.font = FONT(12);
        _numberLabel = label;
    }
    return _numberLabel;
}

- (UILabel *)numberDescLabel{
    if (!_numberDescLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(12);
        label.text = @"人次";
        [label sizeToFit];
        _numberDescLabel = label;
    }
    return _numberDescLabel;
}

- (UILabel *)operateLabel{
    if (!_operateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = RGB(58, 123, 226);
        label.font = FONT(12);
        label.text = @"查看号码";
        [label sizeToFit];
        label.userInteractionEnabled = YES;
        weakify(self);
        [label bk_whenTapped:^{
            strongify(self);
            LRDetailRecordModel *model = self.cellData;
            [[TTNavigationService sharedService]openUrl:model.link];
        }];
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
