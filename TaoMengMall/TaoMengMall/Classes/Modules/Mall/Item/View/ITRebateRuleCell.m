//
//  ITRebateRuleCell.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/12.
//  Copyright © 2017年 任梦晗. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "ITRebateRuleCell.h"

@interface ITRebateRuleCell()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;

@end

@implementation ITRebateRuleCell

- (void)drawCell
{
	self.backgroundColor = RGB(255, 246, 246);
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.contentLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        NSString *cashback = (NSString *)self.cellData;
        self.contentLabel.text = cashback;
        [self.contentLabel sizeToFit];
        self.contentLabel.top = self.titleLabel.bottom +4;
        self.contentLabel.left = 12;
        
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 75;
	}
    return height;
}

#pragma mark - Subviews
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Theme_Color;
		label.text = @"商品返利规则";
        label.left = 12;
        label.top = 15;
		[label sizeToFit];
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UILabel *)contentLabel
{
	if (!_contentLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray140;
		label.text = @"购买商品得500淘米 每日返还 最长300天返完";
		[label sizeToFit];
        label.top = self.titleLabel.bottom +4;
        label.left = 12;
		_contentLabel = label;
	}
	return _contentLabel;
}

#pragma mark - Actions
#pragma mark - Actions


@end
