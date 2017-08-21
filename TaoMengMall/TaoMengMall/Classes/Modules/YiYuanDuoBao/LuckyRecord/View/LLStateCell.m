//
//  LLStateCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LLStateCell.h"
#import "LuckyRecordItemModel.h"

@interface LLStateCell ()

@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation LLStateCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.stateLabel];
    [self cellAddSubView:self.line];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 52;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        LuckyRecordItemModel *model  = self.cellData;
        
        self.stateLabel.text = model.status.desc;
        [self.stateLabel sizeToFit];
        self.stateLabel.centerY = 26;
        self.stateLabel.right = SCREEN_WIDTH - 12;
        
        self.line.bottom = [[self class] heightForCell:self.cellData];
    }
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Theme_Color;
        label.font = FONT(14);
        _stateLabel = label;
    }
    return _stateLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}

@end
