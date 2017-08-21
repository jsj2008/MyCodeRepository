//
//  ITCommentFootCell.m
//  FlyLantern
//
//  Created by marco on 10/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ITCommentFootCell.h"

@interface ITCommentFootCell ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ITCommentFootCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self addSubview:self.line];
    [self addSubview:self.titleLabel];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 40;
    }
    return height;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        _line = view;
    }
    return _line;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray66;
        label.text = @"查看全部评论";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2;
        label.centerY = 20;
        _titleLabel = label;
    }
    return _titleLabel;
}
@end
