//
//  MHomeItemView.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/24.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MHomeItemView.h"
#import "MHItemModel.h"

@interface MHomeItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) MHItemModel *model;

@end

@implementation MHomeItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self render];
    }
    return self;
}

- (void)render
{
    self.backgroundColor = Color_White;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.moreImageView];
    [self addSubview:self.line];
   
    
    [self bk_whenTapped:^{
        [[TTNavigationService sharedService] openUrl:_model.link];
    }];
}

- (void)reloadData:(MHItemModel*)viewData
{
    _model = viewData;
    if (viewData) {
    
        
        self.titleLabel.text = _model.title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 57 / 2.0f;
        self.titleLabel.left = 12;
        
        self.descLabel.text = _model.desc;
        [self.descLabel sizeToFit];
        self.descLabel.centerY = 57 / 2.0f;
        self.descLabel.left = self.titleLabel.right + 12;
        
        [self.moreImageView setOnlineImage:_model.image];
        
        self.line.bottom = 57;
    }
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray42;
        label.font = FONT(16);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(13);
        _descLabel = label;
    }
    return _descLabel;
}

- (UIImageView *)moreImageView{
    if (!_moreImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 118, 36)];
        imageView.centerY = 57 / 2.0f;
        imageView.right = SCREEN_WIDTH - 12;
        _moreImageView = imageView;
    }
    return _moreImageView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        _line = view;
    }
    return _line;
}

@end
