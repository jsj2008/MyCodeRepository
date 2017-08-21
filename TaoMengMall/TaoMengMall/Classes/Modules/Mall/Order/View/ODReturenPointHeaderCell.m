//
//  ODReturenPointHeaderCell.m
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


#import "ODReturenPointHeaderCell.h"
#import "ODReturnPointTotalModel.h"

@interface ODReturenPointHeaderCell ()

@property (nonatomic,strong) UILabel *returnLabel;
@property (nonatomic,strong) UILabel *returnValueLabel;

@property (nonatomic,strong) UILabel *noReturnLabel;
@property (nonatomic,strong) UILabel *noReturnValueLabel;

@property (nonatomic,strong) UIView *lineView;

@end

@implementation ODReturenPointHeaderCell

- (void)drawCell
{
	self.backgroundColor = Theme_Color;
	[self cellAddSubView:self.returnLabel];
	[self cellAddSubView:self.returnValueLabel];
	[self cellAddSubView:self.noReturnLabel];
	[self cellAddSubView:self.noReturnValueLabel];
	[self cellAddSubView:self.lineView];
}

- (void)reloadData
{
	if (self.cellData) {
        ODReturnPointTotalModel *model = self.cellData;
        
        self.returnValueLabel.text = model.completed;
        [self.returnValueLabel sizeToFit];
        self.returnValueLabel.centerX = self.returnLabel.centerX;
        
        self.noReturnValueLabel.text = model.uncompleted;
        [self.noReturnValueLabel sizeToFit];
        self.noReturnValueLabel.centerX = self.noReturnValueLabel.centerX;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 110;
	}
    return height;
}

#pragma mark - Subviews
- (UILabel *)returnLabel
{
	if (!_returnLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_White;
		label.text = @"已返";
		[label sizeToFit];
        label.centerX = SCREEN_WIDTH/2/2;
        label.top = 25;
		_returnLabel = label;
	}
	return _returnLabel;
}

- (UILabel *)returnValueLabel
{
	if (!_returnValueLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(22);
		label.textColor = Color_White;
		label.text = @"20";
		[label sizeToFit];
        label.centerX = self.returnLabel.centerX;
        label.top = self.returnLabel.bottom + 10;
		_returnValueLabel = label;
	}
	return _returnValueLabel;
}

- (UILabel *)noReturnLabel
{
	if (!_noReturnLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_White;
        label.text = @"未返";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2/2 + SCREEN_WIDTH/2;
        label.top = 25;
		_noReturnLabel = label;
	}
	return _noReturnLabel;
}

- (UILabel *)noReturnValueLabel
{
	if (!_noReturnValueLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        label.font = FONT(22);
        label.textColor = Color_White;
        label.text = @"20";
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH/2/2 + SCREEN_WIDTH/2;
        label.top = self.noReturnLabel.bottom + 10;
        _noReturnValueLabel = label;
	}
	return _noReturnValueLabel;
}

- (UIView *)lineView
{
	if (!_lineView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, LINE_WIDTH, 38)];
		view.backgroundColor = Color_White;
        view.centerY = 110/2;
        view.centerX = SCREEN_WIDTH / 2;
		_lineView = view;
	}
	return _lineView;
}

#pragma mark - Actions
#pragma mark - Actions


@end
