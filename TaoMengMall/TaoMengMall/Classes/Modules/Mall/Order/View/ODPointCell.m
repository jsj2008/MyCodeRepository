//
//  ODPointCell.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/11.
//  Copyright © 2017年 任梦晗. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "ODPointCell.h"

@interface ODPointCell()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *valueLabel;

@end

@implementation ODPointCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.bgView];
	[self.bgView addSubview:self.tipLabel];
	[self.bgView addSubview:self.valueLabel];
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
		height = 46;
	}
    return height;
}

#pragma mark - Subviews
- (UIView *)bgView
{
	if (!_bgView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
		_bgView = view;
	}
	return _bgView;
}

- (UILabel *)tipLabel
{
	if (!_tipLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		label.text = @"<#label#>";
		[label sizeToFit];
		_tipLabel = label;
	}
	return _tipLabel;
}

- (UILabel *)valueLabel
{
	if (!_valueLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		label.text = @"<#label#>";
		[label sizeToFit];
		_valueLabel = label;
	}
	return _valueLabel;
}

#pragma mark - Actions
#pragma mark - Actions


@end
