//
//  PMPDPointBalanceCell.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "PMPDPointBalanceCell.h"

@interface PMPDPointBalanceCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleValueLabel;

@end

@implementation PMPDPointBalanceCell

- (void)drawCell
{
    self.backgroundColor = [UIColor whiteColor];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.titleValueLabel];
}

- (void)reloadData
{
    if (self.cellData) {
        NSString *balance = self.cellData;
        self.titleValueLabel.text = balance;
        
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = SCREEN_WIDTH/2;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 105;
    }
    return height;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"余额";
        [_titleLabel sizeToFit];
        _titleLabel.centerX = SCREEN_WIDTH/2;
        _titleLabel.font = FONT(12);
        _titleLabel.textColor = Color_Gray100;
    }
    return _titleLabel;
}

- (UILabel *)titleValueLabel
{
    if (!_titleValueLabel) {
        _titleValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+5, SCREEN_WIDTH, 40)];
        _titleValueLabel.textAlignment = NSTextAlignmentCenter;
        _titleValueLabel.text = @"0.00";
        _titleValueLabel.font = FONT(32);
        _titleValueLabel.textColor = Theme_Color;
    }
    return _titleValueLabel;
}

@end
