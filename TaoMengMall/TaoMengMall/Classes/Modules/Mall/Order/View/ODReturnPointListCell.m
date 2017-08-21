//
//  ODReturnPointListCell.m
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


#import "ODReturnPointListCell.h"
#import "ODReturnPointRecordModel.h"

@interface ODReturnPointListCell()

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ODReturnPointListCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.timeLabel];
	[self cellAddSubView:self.amountLabel];
    [self cellAddSubView:self.lineView];
}

- (void)reloadData
{
	if (self.cellData) {
        ODReturnPointRecordModel *model = self.cellData;
        self.timeLabel.text = model.time;
        [self.timeLabel sizeToFit];
        self.timeLabel.left = 10;
        
        self.amountLabel.text = model.amount;
        [self.amountLabel sizeToFit];
        self.amountLabel.right = SCREEN_WIDTH -10;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 53;
	}
    return height;
}

#pragma mark - Subviews
- (UILabel *)timeLabel
{
	if (!_timeLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray(102);
		label.text = @"2015-12-23 15:30:46";
		[label sizeToFit];
        label.centerY = 53/2.;
		_timeLabel = label;
	}
	return _timeLabel;
}

- (UILabel *)amountLabel
{
	if (!_amountLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Theme_Color;
		label.text = @"+5";
        label.centerY = 53/2.;
		[label sizeToFit];
		_amountLabel = label;
	}
	return _amountLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(11, 53-LINE_WIDTH, SCREEN_WIDTH-11, LINE_WIDTH)];
        view.backgroundColor = Color_Gray(233);
        _lineView = view;
    }
    return _lineView;
}

#pragma mark - Actions
#pragma mark - Actions


@end
