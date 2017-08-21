//
//  MBOverseaCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/27.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MBOverseaCell.h"
#import "MBOverseaModel.h"

@interface MBOverseaCell ()

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation MBOverseaCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.coverView];
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.descLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        
        MBOverseaModel *model = self.cellData;
        
        [self.coverView setOnlineImage:model.image];
        
        self.titleLabel.text = model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = SCREEN_WIDTH / 2.0f;
        self.titleLabel.top = self.coverView.bottom + 10;
        
        self.descLabel.text = model.address;
        [self.descLabel sizeToFit];
        self.descLabel.centerX = SCREEN_WIDTH/2.0f;
        self.descLabel.top = self.titleLabel.bottom + 10;
        
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 215;
	}
    return height;
}

- (UIImageView *)coverView
{
	if (!_coverView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
		_coverView = imageView;
	}
	return _coverView;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray42;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UILabel *)descLabel
{
	if (!_descLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray153;
		_descLabel = label;
	}
	return _descLabel;
}



@end
