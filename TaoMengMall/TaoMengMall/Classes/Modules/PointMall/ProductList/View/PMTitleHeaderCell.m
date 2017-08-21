//
//  PMTitleHeaderCell.m
//  CarKeeper
//
//  Created by 任梦晗 on 17/5/9.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "PMTitleHeaderCell.h"

@interface PMTitleHeaderCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation PMTitleHeaderCell


- (void)reloadData
{
    
    if (self.cellData) {
        
        
        [self cellAddSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.descLabel];
        
        NSString *title = self.cellData;
        
        self.titleLabel.text = title;
        [self.titleLabel sizeToFit];
        self.titleLabel.centerY = 26;
        self.titleLabel.left = 12;
        
        
    }
}

- (UIView *)bgView
{
    if (!_bgView ) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
        view.backgroundColor = Color_White;
        _bgView = view;
    }
    return _bgView;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(16);
        label.textColor = Color_Gray100;
        _titleLabel = label;
    }
    return _titleLabel;
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 62;
        
    }
    return height;
}


@end
