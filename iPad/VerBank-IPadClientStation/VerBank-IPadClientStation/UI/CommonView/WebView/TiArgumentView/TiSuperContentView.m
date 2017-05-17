//
//  TiSuperContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/27.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TiSuperContentView.h"
#import "KZColorPicker.h"
#import "IOSLayoutDefine.h"
#import "ColorFullButton.h"
#import "LangCaptain.h"

@interface TiSuperContentView() {
    UIView *container;
    KZColorPicker *colorPicker;
    ColorFullButton *commitBtn;
}

@end

@implementation TiSuperContentView

@synthesize index;
@synthesize config;

- (void)commitArgument {}
- (void)resetArgument {}
- (void)setTiArgumentConfig:(TiArgumentConfig *)config withIndex:(int)index {}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {

}

- (void)showColorPicker:(id)sender {
    container  = [[UIView alloc] init];
    container.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
    
    colorPicker = [[KZColorPicker alloc] initWithFrame:CGRectMake(0, 0, 400, 280)];
    
    //    colorPicker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [colorPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    commitBtn = [[ColorFullButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 220, SCREEN_HEIGHT - 200, 70, 30)];
    [commitBtn setStyle:ButtonBlue];
    [commitBtn setCorner:10.0f];
    [commitBtn addTarget:self action:@selector(colorChange:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:[[LangCaptain getInstance] getLangByCode:@"YES"] forState:UIControlStateNormal];
    
    
    
    [container addSubview:commitBtn];
    [container addSubview:colorPicker];
    [self.superview.superview addSubview:container];
    _currentButton = sender;
    [self setNeedsLayout];
}

- (void)colorChange:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [[((UIButton *)sender) superview] removeFromSuperview];
    }
}

- (void) pickerChanged:(KZColorPicker *)cp {
    [_currentButton setBackgroundColor:cp.selectedColor];
}

- (void)initPickButton:(UIButton *)button {
    [button.layer setCornerRadius:5.0f];
    [button.layer setBorderWidth:1.0f];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.superview.bounds;
    [container setFrame:bounds];
    [colorPicker setCenter:CGPointMake(bounds.size.width / 2, bounds.size.height / 2)];
    [commitBtn setFrame:CGRectMake(bounds.size.width - 100, bounds.size.height - 100, 80, 30)];
}

@end
