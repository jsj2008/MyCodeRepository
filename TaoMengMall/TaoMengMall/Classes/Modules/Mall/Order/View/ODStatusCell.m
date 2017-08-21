//
//  ODStatusCell.m
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


#import "ODStatusCell.h"

@interface ODStatusCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ODStatusCell

- (void)drawCell
{
	self.backgroundColor = Theme_Color;
	[self cellAddSubView:self.titleLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        NSString *status = (NSString*)self.cellData;
        self.titleLabel.text = status;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 29;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 58;
	}
	return height;
}

#pragma mark - Subviews
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 0, 0)];
		label.font = FONT(20);
        label.textColor = Color_White;
		_titleLabel = label;
	}
	return _titleLabel;
}
@end
