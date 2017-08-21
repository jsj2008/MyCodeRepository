//
//  MCTopDressModuleView.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/21.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MCCategoryModuleView.h"

@interface MCCategoryModuleView()
@property (nonatomic,strong) MCCategoryModuleModel *model;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MCCategoryModuleView

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
    [self addSubview:self.titleLabel];
    self.iconImageView.centerX = self.width/2;
    self.titleLabel.top = self.iconImageView.bottom + 6;
    weakify(self);
    [self bk_whenTapped:^{
        strongify(self);
        [[TTNavigationService sharedService] openUrl:self.model.link];
    }];
}

- (void)reloadData:(MCCategoryModuleModel*)viewData
{
    _model = viewData;
    if (_model) {
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        
        [self.iconImageView setOnlineImage:_model.imageSrc placeHolderImage:[UIImage imageNamed:@"placeholder_h"]];
        self.titleLabel.text = _model.name;
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
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 66, 85)];
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray(45);
        _titleLabel = label;
    }
    return _titleLabel;
}


@end
