//
//  LRNumberDetailRecordCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LRNumberDetailRecordCell.h"

@interface LRNumberDetailRecordCell ()

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation LRNumberDetailRecordCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.numberLabel];
    [self cellAddSubView:self.line];
}

- (void)reloadData
{
	if (self.cellData) {
        self.numberLabel.text = self.cellData;
        [self.numberLabel sizeToFit];
        self.numberLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        self.line.bottom = 35;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 35;
	}
    return height;
}

- (UILabel *)numberLabel
{
	if (!_numberLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray42;
		_numberLabel = label;
	}
	return _numberLabel;
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
