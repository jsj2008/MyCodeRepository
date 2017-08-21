//
//  RFReasonInputCell.m
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "RFReasonInputCell.h"
#import "NoMenuTextField.h"
#import "RFApplyIdValueModel.h"
#import "RefundApplyModel.h"

@interface RFReasonInputCell ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *starIcon;

@property (nonatomic, strong) NoMenuTextField *textField;
@property (nonatomic, strong) NSArray *reasonList;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation RFReasonInputCell

- (void)drawCell
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.starIcon];
    
    self.starIcon.left = self.titleLabel.right + 2;
    self.starIcon.centerY = self.titleLabel.centerY;
    
    [self addSubview:self.textField];
    self.textField.top = self.titleLabel.bottom + 10;
    self.descLabel.top = self.textField.bottom + 5;
}

- (void)reloadData
{
    if (self.cellData) {
        RefundApplyModel *model = (RefundApplyModel*)self.cellData;
        
        NSMutableArray *typeList = [NSMutableArray array];
        for (RFApplyIdValueModel *kv in self.reasons) {
            [typeList addObject:kv.value];
        }
        self.reasonList = typeList;
        
        NSInteger index = -1;
        for (int i = 0; i < self.reasons.count; i++) {
            RFApplyIdValueModel *reason = [self.reasons safeObjectAtIndex:i];
            if (reason.typeId  == model.reason) {
                index = i;
            }
        }
        if (index != - 1) {
            self.selectedIndex = index;
            self.textField.text = [self.reasonList safeObjectAtIndex:index];
        }else{
            self.selectedIndex = 0;
        }
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
        label.text = @"退款原因";
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

- (UILabel*)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(12);
        _descLabel = label;
    }
    return _descLabel;
}

- (NoMenuTextField*)textField
{
    if (!_textField) {
        NoMenuTextField *textField = [[NoMenuTextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 46)];
        textField.font = FONT(16);
        //textField.textColor = Color_Gray153;
        textField.backgroundColor = Color_White;
        textField.placeholder = @"请选择退款类型";
        UIView *bkgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 6)];
        view.image = [UIImage imageNamed:@"cell_drop_down"];
        
        [bkgView addSubview:view];
        view.centerX = bkgView.width/2;
        view.centerY = bkgView.height/2;
        
        textField.rightView = bkgView;
        textField.rightViewMode = UITextFieldViewModeAlways;
        
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        topView.backgroundColor = Color_White;
        UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace1,btnSpace2,doneButton,nil];
        [topView setItems:buttonsArray];
        textField.inputAccessoryView = topView;
        
        textField.inputView = self.pickerView;
        
        textField.delegate = self;
        _textField = textField;
    }
    return _textField;
}

- (UIPickerView*)pickerView
{
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 224)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        _pickerView = pickerView;
    }
    
//    [_pickerView selectRow:self.selectedIndex inComponent:0 animated:NO];
//    self.textField.text = [self.reasonList safeObjectAtIndex:self.selectedIndex];
//    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
//    RFApplyIdValueModel *reason = [self.reasons safeObjectAtIndex:self.selectedIndex];
//    model.reason = reason.typeId;

    return _pickerView;
}

- (void)dismissKeyBoard
{
    [self.textField resignFirstResponder];
}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.reasonList.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.reasonList safeObjectAtIndex:row];
}

#pragma mark - UIPickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
    RFApplyIdValueModel *reason = [self.reasons safeObjectAtIndex:row];
    model.reason = reason.typeId;
    self.selectedIndex = row;
    self.textField.text = [self.reasonList safeObjectAtIndex:row];
}


#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.pickerView selectRow:self.selectedIndex inComponent:0 animated:NO];

    //NSInteger row = [self.pickerView selectedRowInComponent:self.selectedIndex];
    textField.text = [self.reasonList safeObjectAtIndex:self.selectedIndex];
    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
    RFApplyIdValueModel *reason = [self.reasons safeObjectAtIndex:self.selectedIndex];
    model.reason = reason.typeId;
    //self.selectedIndex = row;
}
@end
