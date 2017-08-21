//
//  CSPlatformCouponCell.m
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSPlatformCouponCell.h"
#import "CSPlatformCouponModel.h"

@interface CSPlatformCouponCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *moreImageView;

@property (nonatomic, strong) UIView *line;

@end

@implementation CSPlatformCouponCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.moreImageView];
    [self addSubview:self.line];
}

- (void)reloadData
{
    self.titleLabel.text = @"选择全场优惠券";
    [self.titleLabel sizeToFit];
    self.titleLabel.centerY = [[self class] heightForCell:@""]/2;
    
    self.line.bottom = [[self class] heightForCell:self.cellData];

    if (self.cellData) {
        CSPlatformCouponModel *model = (CSPlatformCouponModel*)self.cellData;
        self.detailLabel.text = model.title;

    }else{
        self.detailLabel.text = @"未选择优惠券";
    }
    [self.detailLabel sizeToFit];
    self.detailLabel.width = self.moreImageView.left - 2 - self.titleLabel.right - 12;
    self.detailLabel.right = self.moreImageView.left - 2;
    self.detailLabel.centerY = self.titleLabel.centerY;
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 44;
    }
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

- (UILabel*)detailLabel
{
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray113;
        label.textAlignment = NSTextAlignmentRight;
        _detailLabel = label;
    }
    return _detailLabel;
}


- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = 22;
        _moreImageView.right = SCREEN_WIDTH - 15;
    }
    
    return _moreImageView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray209;
        _line = view;
    }
    return _line;
}

@end
