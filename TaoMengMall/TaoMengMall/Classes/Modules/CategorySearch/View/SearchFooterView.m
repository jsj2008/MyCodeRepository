//
//  SearchFooterView.m
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "SearchFooterView.h"

@interface SearchFooterView ()
@end

@implementation SearchFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.separatorView];
        [self addSubview:self.titleLabel];
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = self.width / 2;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _separatorView.top = self.height - 1;
}

- (UIView*)separatorView
{
    if (!_separatorView) {
        _separatorView = [[UIView alloc]initWithFrame:CGRectMake(20, self.height - 1, self.width-40, 1)];
        _separatorView.backgroundColor = [UIColor lightGrayColor];
    }
    return _separatorView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, self.width-40, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"暂无历史搜索";
    }
    return _titleLabel;
}
@end
