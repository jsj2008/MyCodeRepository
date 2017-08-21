//
//  MCSearchBarView.m
//  LianWei
//
//  Created by marco on 7/12/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "MCSearchBarView.h"

@interface MCSearchBarView ()
@property (nonatomic, strong) UIView *bkgView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation MCSearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_White;
        [self render];
    }
    return self;
}

- (void)render
{
    [self addSubview:self.bkgView];
    [self.bkgView addSubview:self.iconView];
    [self.bkgView addSubview:self.placeHolderLabel];
    self.iconView.centerY = self.height/2;
    self.iconView.left = 15;
    
    self.placeHolderLabel.centerY = self.height/2;
    self.placeHolderLabel.left = self.iconView.right + 12;
}

#pragma mark -Subviews

- (UIView*)bkgView
{
    if (!_bkgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        view.layer.borderColor = Color_Gray224.CGColor;
        view.layer.borderWidth = 1.f;
        view.layer.cornerRadius = 2.f;
        view.layer.masksToBounds = YES;
        view.userInteractionEnabled = YES;
        [view bk_whenTapped:^{
            [[TTNavigationService sharedService] openUrl:@"xiaoma://search?type=1"];
        }];
        _bkgView = view;
    }
    return _bkgView;
}

- (UIImageView*)iconView
{
    if (!_iconView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 15, 15)];
        imageView.image = [UIImage imageNamed:@"search_bar_icon"];
        _iconView = imageView;
    }
    return _iconView;
}

- (UILabel*)placeHolderLabel
{
    if (!_placeHolderLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray169;
        label.text = @"搜索商品";
        [label sizeToFit];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

@end
