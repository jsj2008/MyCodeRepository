//
//  ODPayMethodCell.m
//  FlyLantern
//
//  Created by marco on 19/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//
/*---------------XMCodeGenerator information--------------

			    Home:https://github.com/Mamong/XMCodeGenerator
			 Version:	1.0.4
			   Build:	4
--------------------------END----------------------------*/


#import "ODPayMethodCell.h"

@interface ODPayMethodCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ODPayMethodCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.titleLabel];
}

- (void)reloadData
{
	if (self.cellData) {
        NSString *method = (NSString*)self.cellData;
        
        self.titleLabel.text = [NSString stringWithFormat:@"支付方式：%@",method];
        [self.titleLabel sizeToFit];
        self.titleLabel.left = 12;
        self.titleLabel.centerY = 25;
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 50;
	}
	return height;
}

#pragma mark - Subviews
- (UILabel *)titleLabel
{
	if (!_titleLabel) {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 0, 0)];
		label.font = FONT(14);
		label.textColor = Color_Gray153;
		label.text = @"支付方式";
		[label sizeToFit];
        label.centerY = 25;
		_titleLabel = label;
	}
	return _titleLabel;
}


@end
