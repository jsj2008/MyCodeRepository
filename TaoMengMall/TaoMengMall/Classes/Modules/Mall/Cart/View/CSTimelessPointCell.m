//
//  CSTimelessPointCell.m
//  LianWei
//
//  Created by marco on 7/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CSTimelessPointCell.h"
#import "CSAdditionInfoModel.h"

NSString *const CSOrderConfirmUseTimelessPointChanged = @"CSOrderConfirmUseTimelessPointChanged";

@interface CSTimelessPointCell ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *totalPointLabel;
@property (nonatomic, strong) UILabel *availablePointLabel;
@property (nonatomic, strong) UILabel *usePointLabel;
@property (nonatomic, strong) UISwitch *pointSwitch;
@property (nonatomic, strong) UITextField *pointTextField;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@end

@implementation CSTimelessPointCell

- (void)drawCell
{
    self.backgroundColor = Color_White;
    [self addSubview:self.totalPointLabel];
    [self addSubview:self.availablePointLabel];
    [self addSubview:self.usePointLabel];
    [self addSubview:self.pointSwitch];
    [self addSubview:self.pointTextField];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
}

- (void)reloadData
{
    if (self.cellData) {
        CSAdditionInfoModel *model = (CSAdditionInfoModel*)self.cellData;
        
        self.totalPointLabel.text = [NSString stringWithFormat:@"永久积分总计: %ld",(long)model.timelessPoint];
        [self.totalPointLabel sizeToFit];
        self.totalPointLabel.centerY = 22;
        
        self.availablePointLabel.text = [NSString stringWithFormat:@"可用积分: %ld",(long)model.timelessPointAmountMax];
        [self.availablePointLabel sizeToFit];
        self.availablePointLabel.width = self.usePointLabel.left - 4 -12;
        self.availablePointLabel.centerY = 44 + 22;
        
        self.pointSwitch.enabled = model.canUseTimelessPoint && (model.timelessPointAmountMax>0) && (model.timelessPoint>0);
        
        if (model.useTimelessPoint) {
            
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
        CSAdditionInfoModel *model = (CSAdditionInfoModel*)cellData;
        height = 44;
        if (model.useTimelessPoint) {
            height = 88;
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
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 6, 80, 30)];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textAlignment = NSTextAlignmentRight;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.delegate = self;
        //textField.layer.borderColor = Color_Gray230.CGColor;
        //textField.layer.borderWidth = LINE_WIDTH;
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
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH - 12*2, LINE_WIDTH)];
        view.backgroundColor = Color_Gray230;
        view.bottom = 44;
        _line1 = view;
    }
    return _line1;
}

- (UIView*)line2
{
    if (!_line2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH - 12*2, LINE_WIDTH)];
        view.backgroundColor = Color_Gray230;
        view.bottom = 88;
        _line2 = view;
    }
    return _line2;
}

#pragma mark - Swith method
- (void)textFieldDidChange:(UITextField*)textField
{
    CSAdditionInfoModel *model = (CSAdditionInfoModel*)self.cellData;
    model.tPoint = [textField.text integerValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CSAdditionInfoModel *model = (CSAdditionInfoModel*)self.cellData;
    if ( model.tPoint > model.timelessPointAmountMax ||
        model.tPoint > model.timelessPoint) {
        model.tPoint = MIN(model.timelessPointAmountMax, model.timelessPoint);
        textField.text = [NSString stringWithFormat:@"%ld",model.tPoint];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:CSOrderConfirmUseTimelessPointChanged object:nil];
}

- (void)handlePointSwitich
{
    CSAdditionInfoModel *model = (CSAdditionInfoModel*)self.cellData;
    model.useTimelessPoint = self.pointSwitch.on;
    [[NSNotificationCenter defaultCenter] postNotificationName:CSOrderConfirmUseTimelessPointChanged object:nil];
}

@end
