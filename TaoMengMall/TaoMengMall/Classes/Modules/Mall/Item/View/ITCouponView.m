//
//  ITCouponView.m
//  FlyLantern
//
//  Created by marco on 07/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "ITCouponView.h"

@interface ITCouponView ()
@property (nonatomic, strong) UIImageView *dashImageView;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *parLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIImageView *receiptedImageView;
@end

@implementation ITCouponView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self render];
        [self bk_whenTapped:^{
            if ([self.delegate respondsToSelector:@selector(didTapCouponView:)]) {
                [self.delegate didTapCouponView:self];
            }
        }];
    }
    return self;
}

- (void)render
{
    [self addSubview:self.dashImageView];
	[self addSubview:self.currencyLabel];
	[self addSubview:self.parLabel];
	[self addSubview:self.infoLabel];
	[self addSubview:self.receiptedImageView];
}

- (void)reloadData:(id)data
{
    if (data) {
        [self.parLabel sizeToFit];
        self.parLabel.centerX = self.width/2;
        self.parLabel.top = 5;
        
        self.currencyLabel.right = self.parLabel.left - 4;
        self.currencyLabel.top = 10;
        
        [self.infoLabel sizeToFit];
        self.infoLabel.centerX = self.width/2;
        self.infoLabel.bottom = self.height - 14;
    }
}

#pragma mark - Subviews
- (UIImageView*)dashImageView
{
    if (!_dashImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, self.width - 6, self.height-6)];
        imageView.image = [UIImage imageNamed:@"mall_item_coupon_dash"];
        _dashImageView = imageView;
    }
    return _dashImageView;
}

- (UILabel *)currencyLabel
{
	if (!_currencyLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(8);
		label.textColor = Color_White;
		label.text = @"￥";
		[label sizeToFit];
		_currencyLabel = label;
	}
	return _currencyLabel;
}

- (UILabel *)parLabel
{
	if (!_parLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(23);
		label.textColor = Color_White;
		_parLabel = label;
	}
	return _parLabel;
}

- (UILabel *)infoLabel
{
	if (!_infoLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(10);
		label.textColor = Color_White;
		_infoLabel = label;
	}
	return _infoLabel;
}

- (UIImageView *)receiptedImageView
{
	if (!_receiptedImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 38, 30)];
		imageView.image = [UIImage imageNamed:@"mall_item_coupon_receipted"];
        imageView.bottom = self.height;
        imageView.right = self.width;
		_receiptedImageView = imageView;
	}
	return _receiptedImageView;
}
@end
