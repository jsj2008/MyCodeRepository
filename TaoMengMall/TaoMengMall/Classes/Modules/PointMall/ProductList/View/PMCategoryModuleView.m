//
//  PMCategoryModuleView.m
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "PMCategoryModuleView.h"
#import "PMCatesModel.h"

@interface PMCategoryModuleView()
@property (nonatomic, strong) PMCatesModel *model;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation PMCategoryModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self render];
    }
    return self;
}

- (void)render
{
    [self addSubview:self.iconImageView];
    // [self addSubview:self.titleLabel];
    self.iconImageView.width = self.width;
    self.iconImageView.height = self.height;
    
    self.titleLabel.top = self.iconImageView.bottom + 6;
    weakify(self);
    [self bk_whenTapped:^{
        strongify(self);
        [[TTNavigationService sharedService] openUrl:self.model.link];
    }];
}

- (void)reloadData:(PMCatesModel*)viewData
{
    _model = viewData;
    
    if (_model) {
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        
        [self.iconImageView setOnlineImage:_model.image];
        self.titleLabel.text = _model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = self.iconImageView.centerX;
    }else{
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
    }
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        // imageView.layer.cornerRadius = 3;
        // imageView.layer.masksToBounds = YES;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = [UIColor whiteColor];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
