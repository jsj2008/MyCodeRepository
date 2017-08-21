//
//  ShopRestrictionTipCell.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/12.
//  Copyright © 2017年 任梦晗. All rights reserved.
//


#import "ShopRestrictionTipCell.h"

@interface ShopRestrictionTipCell()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *tipImageView;
@property (nonatomic,strong) UILabel *tipLabel;

@end

@implementation ShopRestrictionTipCell


- (void)reloadData
{
	if (self.cellData) {

        [self cellAddSubview:self.bgView];
        [self cellAddSubview:self.tipImageView];
        [self cellAddSubview:self.tipLabel];
        
        NSString *tip = (NSString *)self.cellData;
        self.tipLabel.text = tip;
        [self.tipLabel sizeToFit];

	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 48;
	}
    return height;
}

#pragma mark - Subviews

- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 38)];
        view.backgroundColor = Color_White;
        _bgView = view;
    }
    return _bgView;
}

- (UIImageView *)tipImageView
{
	if (!_tipImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
		imageView.image = [UIImage imageNamed:@"icon_ restriction_tip"];
        [imageView sizeToFit];
        imageView.centerY = 19;

		_tipImageView = imageView;
	}
	return _tipImageView;
}

- (UILabel *)tipLabel
{
	if (!_tipLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(12);
		label.textColor = Color_Gray(62);
		label.text = @"每人限购10件";
		[label sizeToFit];
        label.centerY = self.tipImageView.centerY;
        label.left = self.tipImageView.right + 3;
        
		_tipLabel = label;
	}
	return _tipLabel;
}

#pragma mark - Actions
#pragma mark - Actions


@end
