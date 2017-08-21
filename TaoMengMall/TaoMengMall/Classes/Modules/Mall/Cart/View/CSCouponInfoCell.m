//
//  CSCouponInfoCell.m
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSCouponInfoCell.h"
#import "TTCheckButton.h"
#import "CSPlatformCouponModel.h"

@interface CSCouponInfoCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TTCheckButton *checkButton;
@property (nonatomic, strong) UIView *line;

@end

@implementation CSCouponInfoCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self addSubview:self.titleLabel];
    [self addSubview:self.checkButton];
    [self addSubview:self.line];
    [self bk_whenTapped:^{
        [self handleCheckButton];
    }];
}

- (void)reloadData
{
    if (self.cellData) {
        
        CSPlatformCouponModel *model = (CSPlatformCouponModel*)self.cellData;
        
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = [[self class] heightForCell:self.cellData]/2;
        
        self.checkButton.selected = model.selected;
        self.checkButton.centerY = self.titleLabel.centerY;
        
        self.line.bottom = [[self class] heightForCell:self.cellData];

    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 44;
    return height;
}

#pragma mark - Subviews

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}


- (TTCheckButton *)checkButton {
    
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] init];
        _checkButton.right = SCREEN_WIDTH - 8;
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (UIView *)line {
    
    if ( !_line ) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        _line.backgroundColor = Color_Gray209;
    }
    
    return _line;
}

#pragma mark - Event Response

- (void) handleCheckButton {
    
//    CSPlatformCouponModel *couponInfo = (CSPlatformCouponModel *)self.cellData;
//    couponInfo.selected = !self.checkButton.isSelected;
//    self.checkButton.selected = !self.checkButton.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapCheckButtonInCell:)]) {
        [self.delegate didTapCheckButtonInCell:self];
    }
}
@end
