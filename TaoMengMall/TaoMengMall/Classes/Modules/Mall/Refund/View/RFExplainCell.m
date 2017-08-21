//
//  RFExplainCell.m
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "RFExplainCell.h"
#import "RefundApplyModel.h"

@interface RFExplainCell ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *tvPlaceHolderLabel;
@end

@implementation RFExplainCell

- (void)drawCell
{
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.textView];
    [self cellAddSubView:self.tipsLabel];
    
    self.textView.top = self.titleLabel.bottom + 10;
}

- (void)reloadData
{
    if (self.cellData) {
        RefundApplyModel *model = (RefundApplyModel*)self.cellData;
        self.textView.text = model.desc;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        return 88+48;
    }
    return 0;
}

#pragma mark - Subviews

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"退款说明";
        [label sizeToFit];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel*)tipsLabel
{
    if (!_tipsLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(148);
        label.text = @"(可不填)";
        [label sizeToFit];
        label.centerY = self.titleLabel.centerY;
        label.left = self.titleLabel.right;
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (UITextView*)textView
{
    if (!_textView) {
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 94)];
        textView.font = FONT(16);
        [textView addSubview:self.tvPlaceHolderLabel];
        textView.delegate = self;
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        topView.backgroundColor = Color_White;
        UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace1,btnSpace2,doneButton,nil];
        [topView setItems:buttonsArray];
        textView.inputAccessoryView = topView;
        
        _textView = textView;
    }
    return _textView;
}

- (UILabel*)tvPlaceHolderLabel
{
    if (!_tvPlaceHolderLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"请输入退款说明";
        label.textColor = Color_Gray(146);
        [label sizeToFit];
        label.centerY = 23;
        _tvPlaceHolderLabel = label;
    }
    return _tvPlaceHolderLabel;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.tvPlaceHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ( IsEmptyString(textView.text) ) {
        self.tvPlaceHolderLabel.hidden = NO;
    } else {
        self.tvPlaceHolderLabel.hidden = YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
    model.desc = textView.text;
}

#pragma mark -
- (void)dismissKeyBoard
{
    [self.textView resignFirstResponder];
}
@end
