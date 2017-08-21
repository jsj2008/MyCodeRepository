//
//  CPBackgroundCell.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIBackgroundCell.h"

@interface CIBackgroundCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *continueButton;
@property (nonatomic, strong) UIButton *recordButton;

@end

@implementation CIBackgroundCell


- (void)drawCell{
    self.backgroundColor = Color_White;
    [self cellAddSubView:self.iconView];
    [self cellAddSubView:self.titleLabel];
    [self cellAddSubView:self.descLabel];
    [self cellAddSubView:self.continueButton];
    [self cellAddSubView:self.recordButton];
}

+ (CGFloat)heightForCell:(id)cellData{
    CGFloat height = 0;
    if (cellData) {
        height = 192;
    }
    return height;
}

- (void)reloadData{
    if (self.cellData) {
        
        self.titleLabel.text = @"参与夺宝成功";
        [self.titleLabel sizeToFit];
        self.titleLabel.top = 32;
        self.titleLabel.centerX = SCREEN_WIDTH / 2.0f + self.iconView.width/2;
        
        self.iconView.right = self.titleLabel.left - 4;
        self.iconView.centerY = self.titleLabel.centerY;
        
        self.descLabel.text = @"请等待系统为您揭晓！";
        [self.descLabel sizeToFit];
        self.descLabel.top = self.titleLabel.bottom + 16;
        self.descLabel.centerX = SCREEN_WIDTH/2;
        
        self.continueButton.top = self.descLabel.bottom + 24;
        self.continueButton.right = SCREEN_WIDTH / 2.0f - 8;
        
        self.recordButton.top = self.continueButton.top;
        self.recordButton.left = SCREEN_WIDTH / 2.0f + 8;
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
        label.font = FONT(18);
        label.textColor = RGB(234, 66, 74);
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

- (UIButton *)continueButton{
    if (!_continueButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = 140;
        button.height = 40;
        [button setTitleColor:RGB(249, 218, 109) forState:UIControlStateNormal];
        [button setTitle:@"继续夺宝" forState:UIControlStateNormal];
        [button setTitleColor:Color_Black forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.borderColor = Color_Black.CGColor;
        button.layer.cornerRadius = 2.;
        button.layer.masksToBounds = YES;
        button.backgroundColor = RGB(255, 216, 86);
        [button addTarget:self action:@selector(handleContinueButton) forControlEvents:UIControlEventTouchUpInside];
        _continueButton = button;
    }
    return _continueButton;
}

- (UIButton *)recordButton{
    if (!_recordButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = 140;
        button.height = 40;
        [button setTitleColor:Color_White forState:UIControlStateNormal];
        [button setTitle:@"夺宝记录" forState:UIControlStateNormal];
        [button setTitleColor:Color_Black forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.borderColor = Color_Gray216.CGColor;
        button.layer.cornerRadius = 2.;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(handleRecordButton) forControlEvents:UIControlEventTouchUpInside];
        _recordButton = button;
    }
    return _recordButton;
}

#pragma mark - methods

- (void)handleContinueButton{
    if ([self.delegate respondsToSelector:@selector(handleContinueButton)]) {
        [self.delegate  handleContinueButton];
    }
}

- (void)handleRecordButton{
    if ([self.delegate respondsToSelector:@selector(handleRecordButton)]) {
        [self.delegate handleRecordButton];
    }
}

@end
