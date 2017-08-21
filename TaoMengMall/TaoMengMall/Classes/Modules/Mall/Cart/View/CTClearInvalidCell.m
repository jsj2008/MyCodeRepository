//
//  CTClearInvalidCell.m
//  FlyLantern
//
//  Created by marco on 17/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "CTClearInvalidCell.h"

@interface CTClearInvalidCell ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *title;
@end

@implementation CTClearInvalidCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.title];
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

- (UILabel*)title
{
    if (!_title) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(62);
        label.text = @"清空失效商品";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2;
        label.centerY = 20;
        _title = label;
    }
    return _title;
}

@end
