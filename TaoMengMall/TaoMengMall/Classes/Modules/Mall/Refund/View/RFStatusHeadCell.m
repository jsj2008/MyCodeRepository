//
//  RFStatusHeadCell.m
//  FlyLantern
//
//  Created by marco on 21/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "RFStatusHeadCell.h"

@interface RFStatusHeadCell ()

@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation RFStatusHeadCell

- (void)drawCell
{
    [self cellAddSubView:self.bkgView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.line];
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        return 46;
    }
    return 0;
}

#pragma mark - Subviews
- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 46)];
        line.backgroundColor = Color_White;
        line.layer.cornerRadius = 2.f;
        line.layer.masksToBounds = YES;
        _bkgView = line;
    }
    return _bkgView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(18);
        label.textColor = Color_Gray(45);
        label.text = @"协议记录";
        [label sizeToFit];
        label.centerY = 23;
        label.centerX = SCREEN_WIDTH/2;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(12, 50, SCREEN_WIDTH-12-12, LINE_WIDTH)];
        line.backgroundColor = Color_Gray(229);
        line.bottom = 46;
        _line = line;
    }
    return _line;
}

@end
