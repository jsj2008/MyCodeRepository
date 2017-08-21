//
//  LCBackGroundCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LCBackGroundCell.h"

@interface LCBackGroundCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation LCBackGroundCell

- (void)drawCell{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.iconView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.descLabel];
}

+ (CGFloat)heightForCell:(id)cellData
{
    CGFloat height = 0;
    if (cellData) {
        height = 125;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        self.titleLabel.text = @"恭喜您已中奖";
        [self.titleLabel sizeToFit];
        self.titleLabel.centerX = SCREEN_WIDTH / 2.0f + self.iconView.width/2;;
        self.titleLabel.top = 32;
        
        self.iconView.right = self.titleLabel.left - 4;
        self.iconView.centerY = self.titleLabel.centerY;
        
        self.descLabel.text = @"请完善信息等待系统为您派送商品！";
        [self.descLabel sizeToFit];
        self.descLabel.centerX = SCREEN_WIDTH / 2.0f;;
        self.descLabel.top = self.titleLabel.bottom + 18;
    }
}

#pragma mark - getters

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_tip_sucess"];
        [imageView sizeToFit];
        _iconView = imageView;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(20);
        label.textColor = RGB(255, 40, 66);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(14);
        _descLabel = label;
    }
    return _descLabel;
}


@end
