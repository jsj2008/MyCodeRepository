//
//  RVShopRateCell.m
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "RVShopRateCell.h"
#import "ITMarkView.h"
#import "RVShopRateInfoModel.h"

@interface RVShopRateCell ()<ITMarkViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UILabel *logisticsLabel;
@property (nonatomic, strong) ITMarkView *logisticsMarkView;
@property (nonatomic, strong) UILabel *serviceLabel;
@property (nonatomic, strong) ITMarkView *serviceMarkView;
@end

@implementation RVShopRateCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.shopImageView];
	[self cellAddSubView:self.logisticsLabel];
	[self cellAddSubView:self.logisticsMarkView];
	[self cellAddSubView:self.serviceLabel];
	[self cellAddSubView:self.serviceMarkView];
}

- (void)reloadData
{
	if (self.cellData) {
        
        RVShopRateInfoModel *model = (RVShopRateInfoModel*)self.cellData;
        
        self.logisticsMarkView.mark = [model.s integerValue];
        self.logisticsMarkView.centerY = self.logisticsLabel.centerY;
        
        self.serviceMarkView.mark = [model.r integerValue];
        self.serviceMarkView.centerY = self.serviceLabel.centerY;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 132;
	}
	return height;
}

#pragma mark - Subviews
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray66;
		label.text = @"店铺评分";
		[label sizeToFit];
        label.centerY = self.shopImageView.centerY;
		_titleLabel = label;
	}
	return _titleLabel;
}

- (UIImageView *)shopImageView
{
	if (!_shopImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 16, 20, 20)];
		imageView.centerY = 22;
		imageView.image = [UIImage imageNamed:@"mall_shop_logo"];
		_shopImageView = imageView;
	}
	return _shopImageView;
}

- (UILabel *)logisticsLabel
{
	if (!_logisticsLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 55, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray66;
		label.text = @"物流服务";
		[label sizeToFit];
		_logisticsLabel = label;
	}
	return _logisticsLabel;
}

- (ITMarkView*)logisticsMarkView
{
    if (!_logisticsMarkView) {
        ITMarkView *markView = [[ITMarkView alloc]initWithFrame:CGRectMake(85, 57, 0, 0)];
        markView.markWidth = 20;
        markView.showMark = NO;
        [markView sizeToFit];
        markView.delegate = self;
        _logisticsMarkView = markView;
    }
    return _logisticsMarkView;
}

- (UILabel *)serviceLabel
{
	if (!_serviceLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 92, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray66;
		label.text = @"服务态度";
		[label sizeToFit];
		_serviceLabel = label;
	}
	return _serviceLabel;
}

- (ITMarkView*)serviceMarkView
{
    if (!_serviceMarkView) {
        ITMarkView *markView = [[ITMarkView alloc]initWithFrame:CGRectMake(85, 94, 0, 0)];
        markView.markWidth = 20;
        markView.showMark = NO;
        [markView sizeToFit];
        markView.delegate = self;
        _serviceMarkView = markView;
    }
    return _serviceMarkView;
}

#pragma mark -ITMarkViewDelegate
- (void)rateViewValueChanged:(ITMarkView *)rateView
{
    RVShopRateInfoModel *model = (RVShopRateInfoModel*)self.cellData;

    if (rateView == self.logisticsMarkView) {
        model.s = [NSString stringWithFormat:@"%d",(int)rateView.mark];

    }else if (rateView == self.serviceMarkView) {
        model.r = [NSString stringWithFormat:@"%d",(int)rateView.mark];
    }
}

@end
