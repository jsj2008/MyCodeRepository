//
//  CSRemarkCell.m
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


#import "CSRemarkCell.h"
#import "CTShopInfoModel.h"
#import "SZTextView.h"

@interface CSRemarkCell ()<UITextViewDelegate>
@property (nonatomic, strong) SZTextView *textView;
@end

@implementation CSRemarkCell

- (void)drawCell
{
	self.backgroundColor = Color_White;
	[self cellAddSubView:self.textView];
}

- (void)reloadData
{
	if (self.cellData) {
        NSMutableDictionary *remarks = (NSMutableDictionary*)self.cellData;
        self.textView.text = [remarks objectForKey:self.remarkId];
	}
}

+ (CGFloat)heightForCell:(id)cellData
{
	CGFloat height = 0;
	if (cellData) {
		height = 70;
	}
	return height;
}

#pragma mark - Subviews
- (SZTextView *)textView
{
	if (!_textView) {
		SZTextView *textView = [[SZTextView alloc] initWithFrame:CGRectMake(12, 17, SCREEN_WIDTH-24, 36)];
		textView.font = FONT(14);
		textView.placeholder = @"订单补充说明";
        textView.layoutManager.allowsNonContiguousLayout=NO;
        textView.backgroundColor = Color_Gray245;
		textView.delegate = self;
		_textView = textView;
	}
	return _textView;
}

#pragma mark - Actions
- (void)textViewDidChange:(UITextView *)textView
{
	if (textView == self.textView) {
        NSMutableDictionary *remarks = (NSMutableDictionary*)self.cellData;
        if (!IsEmptyString(textView.text)) {
            [remarks setObject:textView.text forKey:self.remarkId];
        }else{
            [remarks removeObjectForKey:self.remarkId];
        }
	}
}
@end
