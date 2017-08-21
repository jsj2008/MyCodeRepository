//
//  ALDatePickerView.m
//  KeHan
//
//  Created by marco on 6/18/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "ALDatePickerView.h"

#define CONTAINER_HEIGHT 365

@interface ALDatePickerView ()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation ALDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        [self render];
    }
    return self;
}

- (instancetype)init
{
    return [[[self class]alloc]initWithFrame:CGRectZero];
}

- (void)render
{
    self.userInteractionEnabled = YES;
    [self addSubview:self.maskView];
    [self addSubview:self.containerView];
}

#pragma mark - Subviews

- (UIView *)maskView {
    
    if ( !_maskView ) {
        _maskView = [[UIView alloc] initWithFrame:self.frame];
        _maskView.backgroundColor = RGBA(0, 0, 0, 0.2);
        _maskView.userInteractionEnabled = YES;
        
        weakify(self);
        [_maskView bk_whenTapped:^{
            strongify(self);
            [self cancelButtonTapped];
        }];
    }
    
    return _maskView;
}

- (UIView *)containerView {
    
    if ( !_containerView ) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - self.pickerView.height - 44, SCREEN_WIDTH, self.pickerView.height + 44)];
        _containerView.backgroundColor = Color_White;
        _containerView.userInteractionEnabled = YES;
        
        [_containerView addSubview:self.toolBar];
        [_containerView addSubview:self.pickerView];
    }
    return _containerView;
}

- (UIDatePicker *)pickerView {
    
    if ( !_pickerView ) {
        _pickerView = [[UIDatePicker alloc] init];
        _pickerView.top = 44;
        _pickerView.centerX = SCREEN_WIDTH/2;
    }
    return _pickerView;
}

- (UIToolbar*)toolBar
{
    if (!_toolBar) {

        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        topView.backgroundColor = Color_White;
        UIBarButtonItem * btnSpace0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        btnSpace0.width = 12;
        UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonTapped)];
        UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(confirmButtonTapped)];
        UIBarButtonItem * btnSpace3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        btnSpace3.width = 12;
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace0,cancelButton,btnSpace1,btnSpace2,doneButton,btnSpace3,nil];
        [topView setItems:buttonsArray];
        _toolBar = topView;
    }
    return _toolBar;
}


#pragma mark - public methods
- (NSDate*)date
{
    return self.pickerView.date;
}


- (void)show
{
    [[ApplicationEntrance shareEntrance].window addSubview:self];
    
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        strongify(self);
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - self.pickerView.height - 44, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)dismiss
{
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        strongify(self);
        
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        
    } completion:^(BOOL finished) {
        
        strongify(self);
        [self removeFromSuperview];
        
    }];
}

#pragma mark - Button actions
- (void)cancelButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewDidCancel:)]) {
        [self.delegate datePickerViewDidCancel:self];
    }
    [self dismiss];
}

- (void)confirmButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewDidConfirm:)]) {
        [self.delegate datePickerViewDidConfirm:self];
    }
    [self dismiss];
}
@end
