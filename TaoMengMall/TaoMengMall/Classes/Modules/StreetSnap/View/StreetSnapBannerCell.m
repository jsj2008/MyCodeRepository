//
//  StreetSnapBannerCell.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			Version:	1.0.3
			  Build:	3
--------------------------END----------------------------*/


#import "StreetSnapBannerCell.h"
#import "StreetSnapeBannerModel.h"

@interface StreetSnapBannerCell()

@property (nonatomic,strong) UIImageView *coverImageView;
@end

@implementation StreetSnapBannerCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.coverImageView];
}

- (void)reloadData
{
	if (self.cellData) {
        
        StreetSnapeBannerModel *model = self.cellData;
        self.coverImageView.height = SCREEN_WIDTH / model.ar;
        [self.coverImageView setOnlineImage:model.image];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
        StreetSnapeBannerModel *model = cellData;
		height = SCREEN_WIDTH / model.ar;
	}
    return height;
}

#pragma mark - Subviews
- (UIImageView *)coverImageView
{
	if (!_coverImageView) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
		//imageView.layer.cornerRadius = 22;
		//imageView.layer.masksToBounds = YES;
		//imageView.image = [UIImage imageNamed:@"<#imageName#>"];
		_coverImageView = imageView;
	}
	return _coverImageView;
}

#pragma mark - Actions
#pragma mark - Actions


@end
