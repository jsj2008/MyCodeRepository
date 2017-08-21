//
//  SearchHeaderView.m
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "SearchHeaderView.h"

@interface SearchHeaderView()

@end

@implementation SearchHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self render];
    }
    return self;
}

- (void)render
{
    //self.backgroundColor = [UIColor greenColor];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.actionButton];
}

- (UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 16, 12, 12)];
    }
    return _imageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 80, 12)];
        _titleLabel.textColor = Color_Gray(165);
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIButton*)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 12, 16, 12, 12)];
    }
    return _actionButton;
}

@end
