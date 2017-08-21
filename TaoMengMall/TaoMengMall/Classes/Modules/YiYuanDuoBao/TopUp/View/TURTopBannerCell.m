//
//  PRTopBannerCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/13.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "TURTopBannerCell.h"

@interface TURTopBannerCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TURTopBannerCell

- (void)drawCell
{
	self.backgroundColor = Color_Gray238;
	[self cellAddSubView:self.titleLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        self.titleLabel.text = self.cellData;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = [[self class] heightForCell:self.cellData] / 2.0f;
        self.titleLabel.left = 12;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 40;
	}
    return height;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray42;
		_titleLabel = label;
	}
	return _titleLabel;
}
@end
