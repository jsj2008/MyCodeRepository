//
//  ITRecommendTitleCell.m
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "ITRecommendTitleCell.h"

@interface ITRecommendTitleCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ITRecommendTitleCell

- (void)drawCell
{
	[self cellAddSubView:self.titleLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        NSString *title = (NSString*)self.cellData;
        
        self.titleLabel.text = title;
        [self.titleLabel sizeToFit];
        
        self.titleLabel.centerY = 22;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 44;
	}
	return height;
}

#pragma mark - Subview
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray(62);
		_titleLabel = label;
	}
	return _titleLabel;
}
@end
