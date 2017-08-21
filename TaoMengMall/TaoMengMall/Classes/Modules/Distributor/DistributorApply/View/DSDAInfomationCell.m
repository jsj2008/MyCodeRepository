//
//  DSDAInfomationCell.m
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDAInfomationCell.h"
#import "DSDistributorApplyModel.h"

@interface DSDAInfomationCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *line2;
@end

@implementation DSDAInfomationCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.nameLabel];
    [self cellAddSubView:self.nameTextField];
    [self cellAddSubView:self.line];
    [self cellAddSubView:self.phoneLabel];
    [self cellAddSubView:self.phoneTextField];
    [self cellAddSubView:self.line2];
}

- (void)reloadData
{
    if (self.cellData) {
        DSDistributorApplyModel *model = (DSDistributorApplyModel*)self.cellData;
        self.nameTextField.text = model.name;
        self.phoneTextField.text = model.phone;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 116;
    }
    return height;
}

#pragma mark - Subviews
- (UILabel*)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"姓名";
        [label sizeToFit];
        label.centerY = 29;
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UITextField*)nameTextField
{
    if (!_nameTextField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(122, 0, SCREEN_WIDTH - 122 -18, 44)];
        textField.placeholder = @"请输入姓名";
        textField.font = FONT(14);
        textField.centerY = 29;
        [textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _nameTextField = textField;
    }
    return _nameTextField;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 58;
        _line = view;
    }
    return _line;
}

- (UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"手机号码";
        [label sizeToFit];
        label.centerY = 58 + 29;
        _phoneLabel = label;
    }
    return _phoneLabel;
}

- (UITextField*)phoneTextField
{
    if (!_phoneTextField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(122, 0, SCREEN_WIDTH - 122 -18, 44)];
        textField.placeholder = @"请输入手机号码";
        textField.font = FONT(14);
        textField.centerY = 58 + 29;
        [textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextField = textField;
    }
    return _phoneTextField;
}

- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray238;
        view.bottom = 116;
        _line2 = view;
    }
    return _line2;
}

#pragma mark - 
- (void)textFieldChanged:(UITextField*)textField
{
    DSDistributorApplyModel *model = (DSDistributorApplyModel*)self.cellData;
    if (textField == self.nameTextField) {
        model.name = textField.text;
    }else if (textField == self.phoneTextField) {
        model.phone = textField.text;
    }
    if ([self.delegate respondsToSelector:@selector(textFieldDidChanged)]) {
        [self.delegate textFieldDidChanged];
    }
}
@end
