//
//  MHomeModule2View.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHomeModule2View.h"
#import "XMAppThemeHelper.h"

@interface MHomeModule2View ()
@property (nonatomic, strong) NSDictionary *model;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@end

@implementation MHomeModule2View

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_White;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = FONT(14);
        [self render];
    }
    return self;
}

- (void)render
{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    
    self.iconImageView.centerX = self.width/2;
    self.titleLabel.top = self.iconImageView.bottom + 6;
    
    [self bk_whenTapped:^{
        [[TTNavigationService sharedService] openUrl:_model[@"link"]];
    }];
}

- (void)reloadData:(NSDictionary*)viewData
{
    _model = viewData;
    if (_model) {
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        
        [self.iconImageView setOnlineImage: _model[@"icon"] placeHolderImage:[UIImage imageNamed:_model[@"placeholder"]]];
        self.iconImageView.width = [_model[@"iconWidth"] floatValue];
        self.iconImageView.height = [_model[@"iconHeight"] floatValue];
        self.iconImageView.centerX = self.width / 2.0f;
        
        self.titleLabel.font = self.font;
        self.descLabel.font = self.font;
        
        if (_model[@"title"]) {
            self.titleLabel.hidden = NO;
            self.titleLabel.text = _model[@"title"];
            [self.titleLabel sizeToFit];
            self.titleLabel.top = self.iconImageView.bottom + 6;
            if (self.textAlignment == NSTextAlignmentCenter) {
                self.titleLabel.centerX = self.iconImageView.centerX;
            }else if (self.textAlignment == NSTextAlignmentLeft) {
                self.titleLabel.left = 0;
            }else if (self.textAlignment == NSTextAlignmentRight) {
                self.titleLabel.right = self.width;
            }
            
            self.descLabel.top = self.titleLabel.bottom + 4;
        }else{
            self.titleLabel.hidden = YES;
            self.descLabel.top = self.iconImageView.bottom + 6;
        }
        
        if (_model[@"desc"]) {
            self.descLabel.hidden = NO;
            self.descLabel.text = _model[@"desc"];
            [self.descLabel sizeToFit];
            if (self.textAlignment == NSTextAlignmentCenter) {
                self.descLabel.centerX = self.iconImageView.centerX;
            }else if (self.textAlignment == NSTextAlignmentLeft) {
                self.descLabel.left = 0;
            }else if (self.textAlignment == NSTextAlignmentRight) {
                self.descLabel.right = self.width;
            }
            self.descLabel.textColor = [XMAppThemeHelper defaultTheme].mainThemeColor;
        }else{
            self.descLabel.hidden = YES;
        }
    }else{
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.descLabel.hidden = YES;
    }
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray42;
        _descLabel = label;
    }
    return _descLabel;
}
@end
