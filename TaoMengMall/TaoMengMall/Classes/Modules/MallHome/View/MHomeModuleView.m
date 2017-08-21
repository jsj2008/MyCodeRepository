//
//  CAHomeModuleView.m
//  GongWuBao2.0
//
//  Created by marco on 1/11/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "MHomeModuleView.h"

@interface MHomeModuleView ()
@property (nonatomic, strong) NSDictionary *model;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MHomeModuleView

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
        
        [self.iconImageView setOnlineImage:_model[@"icon"] placeHolderImage:[UIImage imageNamed:@"placeholder_s"]];
        self.titleLabel.text = _model[@"title"];
        if (_model[@"ar"]) {
            float ar = [_model[@"ar"] floatValue];
            self.iconImageView.height = self.iconImageView.width / ar;
        }
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = self.iconImageView.centerX;
        self.titleLabel.top = self.iconImageView.bottom + 6;
    }else{
        self.iconImageView.hidden = YES;
        self.titleLabel.hidden = YES;
    }
}

- (UIImageView*)iconImageView
{
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 35, 35)];
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

//- (void)setIsRound:(BOOL)isRound{
//    _isRound = isRound;
//    if (isRound) {
//        self.iconImageView.layer.cornerRadius = 37 /2.0f;
//        self.iconImageView.layer.masksToBounds = YES;
//    }
//}
@end
