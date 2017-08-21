//
//  LRContentCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "TURContentCell.h"
#import "TopUpRecordContentModel.h"

@interface TURContentCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *tradeLabel;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation TURContentCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.timeLabel];
	[self cellAddSubView:self.tradeLabel];
	[self cellAddSubView:self.balanceLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
	if (self.cellData) {
        TopUpRecordContentModel *model = self.cellData;
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 10;
        self.titleLabel.top = 10;
        
        self.timeLabel.text = model.date;
        [self.timeLabel sizeToFit];
        self.timeLabel.left = 10;
        self.timeLabel.top = self.titleLabel.bottom + 4;
        
        self.tradeLabel.text = model.amount;
        [self.tradeLabel sizeToFit];
        self.tradeLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        self.tradeLabel.right = SCREEN_WIDTH - 10;
        
        self.line.bottom = [[self class] heightForCell:self.cellData];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 60;
	}
    return height;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UILabel *)timeLabel
{
	if (!_timeLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_timeLabel = label;
	}
	return _timeLabel;
}

- (UILabel *)tradeLabel
{
	if (!_tradeLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
		_tradeLabel = label;
	}
	return _tradeLabel;
}

- (UILabel *)balanceLabel
{
	if (!_balanceLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray153;
		_balanceLabel = label;
	}
	return _balanceLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}
@end
