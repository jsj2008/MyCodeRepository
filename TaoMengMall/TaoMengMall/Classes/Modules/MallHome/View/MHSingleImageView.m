//
//  MHSingleImageView.m
//  FlyLantern
//
//  Created by marco on 18/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "MHSingleImageView.h"

@interface MHSingleImageView ()
@property (nonatomic, strong) NSDictionary *model;
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation MHSingleImageView

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
    self.iconImageView.width = self.width;
    self.iconImageView.height = self.height;
    [self bk_whenTapped:^{
        [[TTNavigationService sharedService] openUrl:_model[@"link"]];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconImageView.width = self.width;
    self.iconImageView.height = self.height;
}

- (void)reloadData:(NSDictionary*)viewData
{
    _model = viewData;
    if (_model) {
        self.iconImageView.hidden = NO;
        [self.iconImageView setOnlineImage:_model[@"icon"] placeHolderImage:[UIImage imageNamed:_model[@"placeholder"]]];

    }else{
        self.iconImageView.hidden = YES;
    }
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 37, 35)];
        imageView.layer.cornerRadius =2.;
        imageView.layer.masksToBounds = YES;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

@end
