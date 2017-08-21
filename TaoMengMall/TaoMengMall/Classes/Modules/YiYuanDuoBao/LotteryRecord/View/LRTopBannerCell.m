//
//  LRTopBannerCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/30.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRTopBannerCell.h"
@interface LRTopBannerCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation LRTopBannerCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.titleLabel];
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
        self.titleLabel.text = self.cellData;
        [self.titleLabel sizeToFit];
        
        self.titleLabel.left = 8;
        self.titleLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        
        self.line.bottom = 40;
    }
}

#pragma mark - getters

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray42;
        _titleLabel = label;
    }
    return _titleLabel;
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
