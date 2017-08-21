
//
//  LCDescCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LDDescCell.h"

@interface LDDescCell ()
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation LDDescCell

- (void)drawCell{
    [self cellAddSubView:self.descLabel];
    [self cellAddSubView:self.line];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 40;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        NSString *participantTimes = self.cellData;
        NSString *desc = [NSString stringWithFormat:@"我已参与%@人次,以下是所有夺宝记录",self.cellData];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:desc];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:RGB(233, 89, 101) range:NSMakeRange(4, participantTimes.length)];
        self.descLabel.attributedText = attributedStr;
        [self.descLabel sizeToFit];
        self.descLabel.centerX = SCREEN_WIDTH / 2.0f;
        self.descLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
    }
}


- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(12);
        label.textColor = Color_Gray125;
        _descLabel = label;
    }
    return _descLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = 40;
        _line = view;
    }
    return _line;
}

@end
