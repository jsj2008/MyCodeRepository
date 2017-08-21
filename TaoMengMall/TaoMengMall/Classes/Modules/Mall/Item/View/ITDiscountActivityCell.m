//
//  ITDiscountActivityCell.m
//  FlyLantern
//
//  Created by marco on 07/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "ITDiscountActivityCell.h"
#import "ITCouponView.h"

@interface ITDiscountActivityCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *manJianLabel;
@property (nonatomic, strong) UILabel *manJianInfoLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@end

@implementation ITDiscountActivityCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.line];
	[self cellAddSubView:self.scrollView];
	[self cellAddSubView:self.manJianLabel];
	[self cellAddSubView:self.manJianInfoLabel];
	[self cellAddSubView:self.detailLabel];
	[self cellAddSubView:self.moreImageView];
}

- (void)reloadData
{
	if (self.cellData) {
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        //128
		height = 168;
	}
	return height;
}

#pragma mark - Subviews
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(174);
		label.text = @"优惠活动";
		[label sizeToFit];
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UIView *)line
{
	if (!_line) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 128, SCREEN_WIDTH - 12, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
		_line = view;
	}
	return _line;
}

- (UIScrollView *)scrollView
{
	if (!_scrollView) {
		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
		_scrollView = scrollView;
	}
	return _scrollView;
}

- (UILabel *)manJianLabel
{
	if (!_manJianLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(10);
		label.textColor = Color_White;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = Theme_Color;
		label.text = @"满件";
		[label sizeToFit];
        label.width = label.width + 10;
        label.height = label.height + 2;
		_manJianLabel = label;
	}
	return _manJianLabel;
}

- (UILabel *)manJianInfoLabel
{
	if (!_manJianInfoLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(174);
		_manJianInfoLabel = label;
	}
	return _manJianInfoLabel;
}

- (UILabel *)detailLabel
{
	if (!_detailLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray140;
		label.text = @"查看详情";
		[label sizeToFit];
		_detailLabel = label;
	}
	return _detailLabel;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.right = SCREEN_WIDTH -12;
        _moreImageView.centerY = 148;
    }
    
    return _moreImageView;
}

@end
