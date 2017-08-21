//
//  MBOverseaDetailHeaderCell.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/7.
//  Copyright © 2017年 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "MBOverseaDetailHeaderCell.h"
#import "MBOSDetailTitleModel.h"

@interface MBOverseaDetailHeaderCell()
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic,strong) UILabel *descLabel;

@end

@implementation MBOverseaDetailHeaderCell



- (void)reloadData
{
	if (self.cellData) {
        
        MBOSDetailTitleModel *model = self.cellData;
        
        [self cellAddSubview:self.coverImageView];
        [self cellAddSubview:self.imageView1];
        [self cellAddSubview:self.imageView2];
        [self cellAddSubview:self.descLabel];
        
        [self.coverImageView setOnlineImage:model.image];
        self.coverImageView.height = SCREEN_WIDTH / model.ar;
        
        self.imageView1.top = self.coverImageView.bottom + 10;
        self.imageView1.left = 10;
        
        self.descLabel.width = SCREEN_WIDTH - 70- 20;
        self.descLabel.numberOfLines = 0;
        self.descLabel.text = model.desc;
        [self.descLabel sizeToFit];
        
        self.imageView2.right = SCREEN_WIDTH-10;
        self.imageView2.bottom = self.descLabel.bottom;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        MBOSDetailTitleModel *model = cellData;
        
        CGSize contentTextSize = [model.desc sizeWithUIFont:FONT(16) forWidth:SCREEN_WIDTH -35 * 2 - 20];
        height = SCREEN_WIDTH / model.ar + 10 +ceil(contentTextSize.height) + 10;

	}
    return height;
}

#pragma mark - Subviews
- (UIImageView *)coverImageView
{
	if (!_coverImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
		_coverImageView = imageView;
	}
	return _coverImageView;
}

- (UIImageView *)imageView1
{
	if (!_imageView1) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 35, 27)];
		//imageView.layer.cornerRadius = 22;
		//imageView.layer.masksToBounds = YES;
		imageView.image = [UIImage imageNamed:@"mall_left_quotation_mark"];
		_imageView1 = imageView;
	}
	return _imageView1;
}

- (UIImageView *)imageView2
{
	if (!_imageView2) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 35, 27)];
		imageView.centerY = 22;
		//imageView.layer.cornerRadius = 22;
		//imageView.layer.masksToBounds = YES;
		imageView.image = [UIImage imageNamed:@"mall_right_quotation_mark"];
		_imageView2 = imageView;
	}
	return _imageView2;
}

- (UILabel *)descLabel
{
	if (!_descLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(16);
		label.textColor = RGB(45, 45, 45);
		label.text = @"";
		[label sizeToFit];
		_descLabel = label;
	}
	return _descLabel;
}

#pragma mark - Actions
#pragma mark - Actions


@end
