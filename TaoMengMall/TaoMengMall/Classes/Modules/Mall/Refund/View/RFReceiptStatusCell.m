//
//  RFReceiptStatusCell.m
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "RFReceiptStatusCell.h"
#import "RefundApplyModel.h"

@interface RFReceiptStatusCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *starIcon;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *unreceiptLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *receiptLabel;
@property (nonatomic, strong) UIImageView *checkImageView;
@end

@implementation RFReceiptStatusCell

- (void)drawCell
{
	[self cellAddSubView:self.titleLabel];
	[self cellAddSubView:self.starIcon];
	[self cellAddSubView:self.bgView];
    
    self.starIcon.left = self.titleLabel.right + 2;
    self.starIcon.centerY = self.titleLabel.centerY;

    self.bgView.top = self.titleLabel.bottom + 10;
}

- (void)reloadData
{
	if (self.cellData) {
        RefundApplyModel *model = (RefundApplyModel*)self.cellData;
        if ([model.receiptStatus isEqualToString:@"0"]) {
            self.checkImageView.centerY = 23;
        }else{
            self.checkImageView.centerY = 46 + 23;
        }
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 46*3;
	}
	return height;
}

#pragma mark - Subviews
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"收货状态";
        [label sizeToFit];
        label.centerY = 23;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView*)starIcon
{
    if (!_starIcon) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 6, 7)];
        imageView.image = [UIImage imageNamed:@"requiredStar"];
        _starIcon = imageView;
    }
    return _starIcon;
}

- (UIView *)bgView
{
	if (!_bgView) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 94)];
		view.backgroundColor = Color_White;
        UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBgView:)];
        [view addGestureRecognizer:tapGesturRecognizer];
        
        [view addSubview:self.unreceiptLabel];
        [view addSubview:self.receiptLabel];
        [view addSubview:self.line];
        [view addSubview:self.checkImageView];
		_bgView = view;
	}
	return _bgView;
}

- (UILabel *)unreceiptLabel
{
	if (!_unreceiptLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = RGB(255, 40, 66);
		label.text = @"未收到货";
		[label sizeToFit];
        label.centerY = 23;
		_unreceiptLabel = label;
	}
	return _unreceiptLabel;
}

- (UIView *)line
{
	if (!_line) {
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 12*2, LINE_WIDTH)];
		view.backgroundColor = Color_Gray224;
        view.centerY = 46;
		_line = view;
	}
	return _line;
}

- (UILabel *)receiptLabel
{
	if (!_receiptLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = Color_Gray153;
		label.text = @"已收到货";
		[label sizeToFit];
        label.centerY = 46+23;
		_receiptLabel = label;
	}
	return _receiptLabel;
}

- (UIImageView *)checkImageView
{
	if (!_checkImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 19, 14)];
		imageView.centerY = 22;
		imageView.image = [UIImage imageNamed:@"refund_receipt_check"];
        imageView.right = SCREEN_WIDTH - 12*4;
        imageView.centerY = 23;
		_checkImageView = imageView;
	}
	return _checkImageView;
}

#pragma mark - Gesture
- (void)tapBgView:(UITapGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
    if (location.y < 46) {
        model.receiptStatus = @"0";
        self.checkImageView.centerY = 23;
        self.unreceiptLabel.textColor = RGB(255, 40, 66);
        self.receiptLabel.textColor = Color_Gray153;
    }else{
        model.receiptStatus = @"1";
        self.checkImageView.centerY = 46+23;
        self.receiptLabel.textColor = RGB(255, 40, 66);
        self.unreceiptLabel.textColor = Color_Gray153;
    }
}
@end
