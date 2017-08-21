//
//  RFSumCell.m
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "RFSumCell.h"
#import "RefundApplyModel.h"

@interface RFSumCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *starIcon;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation RFSumCell

- (void)drawCell
{
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.starIcon];
    [self cellAddSubView:self.tipsLabel];
    [self cellAddSubView:self.contentTextField];
    
    self.starIcon.left = self.titleLabel.right + 2;
    self.starIcon.centerY = self.titleLabel.centerY;
    
    self.contentTextField.top = self.titleLabel.bottom + 10;
}

- (void)reloadData
{
    if (self.cellData) {
        RefundApplyModel *model = (RefundApplyModel*)self.cellData;
        self.contentTextField.text = model.sum;
        self.tipsLabel.text = [NSString stringWithFormat:@"最多%@",self.maxRefundAmount? self.maxRefundAmount:@" "];
        [self.tipsLabel sizeToFit];
        self.tipsLabel.centerY = self.titleLabel.centerY;
        self.tipsLabel.left = self.starIcon.right + 2;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        return 88;
    }
    return 0;
}

#pragma mark - Subviews

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.text = @"退款金额";
        [label sizeToFit];
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

- (UILabel*)tipsLabel
{
    if (!_tipsLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(12);
        label.textColor = Color_Gray(62);
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (UITextField*)contentTextField
{
    if (!_contentTextField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 46)];
        textField.font = FONT(16);
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.backgroundColor = Color_White;
        [textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        textField.placeholder = @"请输入退款金额";
        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        label.text = @"含运费";
//        label.textColor = Color_Gray(148);
//        label.font = FONT(16);
//        [label sizeToFit];
//        label.width += 10;
//        textField.rightView = label;
//        textField.rightViewMode = UITextFieldViewModeAlways;
        
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        topView.backgroundColor = Color_White;
        UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace1,btnSpace2,doneButton,nil];
        [topView setItems:buttonsArray];
        textField.inputAccessoryView = topView;
        textField.delegate = self;
        _contentTextField = textField;
    }
    return _contentTextField;
}

- (UILabel*)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(12);
        _descLabel = label;
    }
    return _descLabel;
}

- (void)dismissKeyBoard
{
    [self.contentTextField resignFirstResponder];
}

- (void)textFieldChanged:(UITextField*)textField
{
    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
    model.sum = textField.text;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text floatValue] == 0.f) {
        textField.text = @"";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:futureString];
}
@end
