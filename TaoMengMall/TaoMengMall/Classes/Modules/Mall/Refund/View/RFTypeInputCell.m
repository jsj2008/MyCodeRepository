//
//  RFTypeInputCell.m
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "RFTypeInputCell.h"
#import "NoMenuTextField.h"
#import "RFApplyIdValueModel.h"
#import "RefundApplyModel.h"

@interface RFTypeInputCell ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *starIcon;

@property (nonatomic, strong) NoMenuTextField *textField;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) NSArray *typeList;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation RFTypeInputCell

- (void)drawCell
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.starIcon];
    
    [self.titleLabel sizeToFit];
    self.starIcon.left = self.titleLabel.right + 2;
    self.starIcon.centerY = self.titleLabel.centerY;
    
    [self addSubview:self.textField];
    self.textField.top = self.titleLabel.bottom + 5;
    self.descLabel.top = self.textField.bottom + 5;
    
    //self.selectedIndex = 0;
}

- (void)reloadData
{
    if (self.cellData) {
        RefundApplyModel *model = (RefundApplyModel*)self.cellData;
        
        NSMutableArray *typeList = [NSMutableArray array];
        for (RFApplyIdValueModel *kv in self.types) {
            [typeList addObject:kv.value];
        }
        self.typeList = typeList;

        NSInteger index = 0;
        for (int i = 0; i < self.types.count; i++) {
            RFApplyIdValueModel *reason = [self.types safeObjectAtIndex:i];
            if (reason.typeId  == model.type) {
                index = i;
            }
        }
        self.selectedIndex = index;
        self.textField.text = [self.typeList safeObjectAtIndex:index];
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 88;
    }
    return height;
}

#pragma mark - Subviews

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(16);
        label.textColor = Color_Gray66;
        label.text = @"退款类型";
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
        NoMenuTextField *textField = [[NoMenuTextField alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12*2, 31)];
        textField.font = FONT(12);
        textField.textColor = Color_Gray66;
        textField.backgroundColor = Color_White;
        UIView *bkgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 36, 36)];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 6)];
        view.image = [UIImage imageNamed:@"cell_drop_down"];

        [bkgView addSubview:view];
        view.centerX = bkgView.width/2;
        view.centerY = bkgView.height/2;
        
        textField.rightView = bkgView;
        textField.rightViewMode = UITextFieldViewModeAlways;
        
        textField.inputView = self.pickerView;
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
    [_pickerView selectRow:self.selectedIndex inComponent:0 animated:NO];
    return _pickerView;
}

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.typeList.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.typeList safeObjectAtIndex:row];
}

#pragma mark - UIPickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    RefundApplyModel *model = (RefundApplyModel*)self.cellData;
    RFApplyIdValueModel *reason = [self.types safeObjectAtIndex:row];
    model.type = reason.typeId;
    self.selectedIndex = row;
    self.textField.text = [self.typeList safeObjectAtIndex:row];
}
@end
