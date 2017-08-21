//
//  CSPointUsageCell.m
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSPointUsageCell.h"
//#import "CSAdditionInfoModel.h"
#import "CSPointShowModel.h"

NSString *const CSOrderConfirmUsePointChanged = @"CSOrderConfirmUsePointChanged";


@interface CSPointUsageCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *totalPointLabel;
@property (nonatomic, strong) UILabel *totalDescLabel;

@property (nonatomic, strong) UILabel *availablePointLabel;
@property (nonatomic, strong) UILabel *usePointLabel;
@property (nonatomic, strong) UISwitch *pointSwitch;
@property (nonatomic, strong) UITextField *pointTextField;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation CSPointUsageCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self addSubview:self.totalPointLabel];
    //[self addSubview:self.availablePointLabel];
    [self addSubview:self.totalDescLabel];
    [self addSubview:self.usePointLabel];
    [self addSubview:self.pointSwitch];
    [self addSubview:self.pointTextField];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
}

- (void)reloadData
{
    if (self.cellData) {
        //CSAdditionInfoModel *model = (CSAdditionInfoModel*)self.cellData;
        CSPointShowModel *model = (CSPointShowModel*)self.cellData;
//        model.switcher = YES;
//        model.inputValue = @"1.89";
//        model.usable = @"10";
//        model.inputEnable = NO;
        
        self.totalPointLabel.text = model.title;
        [self.totalPointLabel sizeToFit];
        self.totalPointLabel.centerY = 22;
        
        self.totalDescLabel.text = [NSString stringWithFormat:@"(%@)",model.totalDesc];
        [self.totalDescLabel sizeToFit];
        self.totalDescLabel.centerY = 22;
        self.totalDescLabel.left = self.totalPointLabel.right;
        
//        self.availablePointLabel.text = @"本次可用";
//        [self.availablePointLabel sizeToFit];
//        self.availablePointLabel.width = self.usePointLabel.left - 4;
//        self.availablePointLabel.centerY = 44 + 22;
        
        self.usePointLabel.text = @"本次使用";
        self.usePointLabel.left = 12;
        self.usePointLabel.centerY = 44 + 22;
        
        self.pointSwitch.enabled = model.switcher && ([model.total floatValue]>0) && ([model.usable floatValue]>0);
        self.pointSwitch.on = model.unfold;
        
        self.pointTextField.left = self.usePointLabel.right;
        self.pointTextField.width = SCREEN_WIDTH - 12 - self.pointTextField.left;
        
        if (model.intValue) {
            self.pointTextField.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            self.pointTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        self.pointTextField.placeholder = model.inputHint;
        self.pointTextField.text = model.inputValue;
        self.pointTextField.enabled = model.inputEnable;
        
        if (model.unfold) {
            
            self.availablePointLabel.hidden = NO;
            self.usePointLabel.hidden = NO;
            self.pointTextField.hidden = NO;
            self.line2.hidden = NO;
        }else{
            
            self.availablePointLabel.hidden = YES;
            self.usePointLabel.hidden = YES;
            self.pointTextField.hidden = YES;
            self.line2.hidden = YES;
        }
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    
    CGFloat height = 0;
    if (cellData) {
        CSPointShowModel *model = (CSPointShowModel*)cellData;
//        model.switcher = YES;
//        model.inputValue = @"1.89";
//        model.usable = @"10";
//        model.inputEnable = NO;
        if (model.show) {
            height = 44;
            if (model.unfold) {
                height = 88;
            }
        }
    }
    return height;
}

#pragma mark - Subviews

- (UILabel*)totalPointLabel
{
    if (!_totalPointLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray113;
        _totalPointLabel = label;
    }
    return _totalPointLabel;
}

- (UILabel*)totalDescLabel
{
    if (!_totalDescLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray170;
        _totalDescLabel = label;
    }
    return _totalDescLabel;
}

- (UILabel*)availablePointLabel
{
    if (!_availablePointLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray113;
        _availablePointLabel = label;
    }
    return _availablePointLabel;
}

- (UILabel*)usePointLabel
{
    if (!_usePointLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.text = @"使用积分:";
        label.textColor = Color_Gray113;
        [label sizeToFit];
        label.right = self.pointTextField.left - 2;
        label.centerY = 44 + 22;
        _usePointLabel = label;
    }
    return _usePointLabel;
}


- (UISwitch*)pointSwitch
{
    if (!_pointSwitch) {
        UISwitch *pointSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [pointSwitch addTarget:self action:@selector(handlePointSwitich) forControlEvents:UIControlEventValueChanged];
        [pointSwitch setOnTintColor:Theme_Color];
        pointSwitch.right = SCREEN_WIDTH - 12;
        pointSwitch.centerY = 22;
        _pointSwitch = pointSwitch;
    }
    return _pointSwitch;
}

- (UITextField*)pointTextField
{
    if (!_pointTextField) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 6, 140, 30)];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textAlignment = NSTextAlignmentRight;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.textColor = Color_Gray113;
        textField.font = FONT(14);
        textField.right = SCREEN_WIDTH -12;
        textField.centerY = 44 + 22;
        _pointTextField = textField;
    }
    return _pointTextField;
}

- (UIView*)line1
{
    if (!_line1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray230;
        view.bottom = 44;
        _line1 = view;
    }
    return _line1;
}

- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray230;
        view.bottom = 88;
        _line2 = view;
    }
    return _line2;
}

#pragma mark - Swith method
- (void)textFieldDidChange:(UITextField*)textField
{
    CSPointShowModel *model = (CSPointShowModel*)self.cellData;
    model.inputValue = textField.text;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CSPointShowModel *model = (CSPointShowModel*)self.cellData;
    if ([model.inputValue floatValue] > [model.usable floatValue]||
        [model.inputValue floatValue] > [model.total floatValue]) {
        if (model.intValue) {
            model.inputValue = [NSString stringWithFormat:@"%d",MIN([model.usable intValue], [model.total intValue])];

        }else{
            model.inputValue = [NSString stringWithFormat:@"%f",MIN([model.usable floatValue], [model.total floatValue])];

        }
        textField.text = [NSString stringWithFormat:@"%@",model.inputValue];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CSOrderConfirmUsePointChanged object:nil];
}

- (void)handlePointSwitich
{
    CSPointShowModel *model = (CSPointShowModel*)self.cellData;
    model.unfold = self.pointSwitch.on;
    [[NSNotificationCenter defaultCenter] postNotificationName:CSOrderConfirmUsePointChanged object:nil];
}
@end
