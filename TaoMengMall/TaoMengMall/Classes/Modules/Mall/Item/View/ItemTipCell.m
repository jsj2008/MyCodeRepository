//
//  ItemTipCell.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/16.
//  Copyright © 2017年 任梦晗. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "ItemTipCell.h"


@interface ItemTipCell()

@property (nonatomic,strong) UIImageView *tipImageView;
@property (nonatomic,strong) UILabel *tipLabel;

@end

@implementation ItemTipCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.tipImageView];
	[self cellAddSubView:self.tipLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        NSString *tip = self.cellData;
        self.tipLabel.text = tip;
        [self.tipLabel sizeToFit];
        self.tipLabel.left = self.tipImageView.right + 5;
        self.tipLabel.centerY = 38/2.0;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 38;
	}
    return height;
}

#pragma mark - Subviews
- (UIImageView *)tipImageView
{
	if (!_tipImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 18, 18)];
		imageView.centerY = 38/2;
        imageView.left = 10;
		//imageView.layer.cornerRadius = 22;
		//imageView.layer.masksToBounds = YES;
		imageView.image = [UIImage imageNamed:@"icon_ restriction_tip"];
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
		[label sizeToFit];
		_tipLabel = label;
	}
	return _tipLabel;
}

#pragma mark - Actions
#pragma mark - Actions


@end
