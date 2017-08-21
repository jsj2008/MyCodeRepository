//
//  ALPickerView.m
//  HongBao
//
//  Created by marco on 6/17/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "ALPickerView.h"

#define CONTAINER_HEIGHT 280

@interface ALPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation ALPickerView

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
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - CONTAINER_HEIGHT, SCREEN_WIDTH, CONTAINER_HEIGHT)];
        _containerView.backgroundColor = Color_White;
        _containerView.userInteractionEnabled = YES;
        
        [_containerView addSubview:self.toolBar];
        [_containerView addSubview:self.pickerView];
    }
    return _containerView;
}

- (UIPickerView *)pickerView {
    
    if ( !_pickerView ) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, CONTAINER_HEIGHT - 44)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
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
- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return [self.pickerView selectedRowInComponent:component];
}

- (void)reloadComponent:(NSInteger)componet
{
    [self.pickerView reloadComponent:componet];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [self.pickerView selectRow:row inComponent:component animated:animated];
}


- (void)show
{
    [[ApplicationEntrance shareEntrance].window addSubview:self];
    
    [self.pickerView reloadAllComponents];
    if (self.pickerView.numberOfComponents > 0) {
        for (int i = 0; i < self.pickerView.numberOfComponents; i++) {
            [self.pickerView selectRow:0 inComponent:i animated:NO];
        }
    }
    weakify(self);
    
    [UIView animateWithDuration:0.3 animations:^{
        strongify(self);
        self.containerView.frame = CGRectMake(0, SCREEN_HEIGHT - CONTAINER_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    } completion:^(BOOL finished) {
        
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

#pragma mark - UIPickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [self.dataSource numberOfComponentsInPickerView:self];
    }else{
        return 0;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.dataSource pickerView:self numberOfRowsInComponent:component];
    }else{
        return 0;
    }
}


#pragma mark - UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [self.delegate pickerView:self titleForRow:row forComponent:component];
    }else{
        return nil;
    }
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [self.delegate pickerView:self didSelectRow:row inComponent:component];
    }
}

#pragma mark - Button actions
- (void)cancelButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewDidCancel:)]) {
        [self.delegate pickerViewDidCancel:self];
    }
    [self dismiss];
}

- (void)confirmButtonTapped
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewDidConfirm:)]) {
        [self.delegate pickerViewDidConfirm:self];
    }
    [self dismiss];
}
@end
