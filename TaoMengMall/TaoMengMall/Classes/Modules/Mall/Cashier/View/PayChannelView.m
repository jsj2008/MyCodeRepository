//
//  PayChannelView.m
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "PayChannelView.h"
#import "TTCheckButton.h"

@interface PayChannelView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) TTCheckButton *checkButton;

@property (nonatomic, strong) NSString *iconImageName;

@end

@implementation PayChannelView

- (instancetype)initWithFrame:(CGRect)frame iconName:(NSString *)iconName channelName:(NSString *)channelName description:(NSString *)description {
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = Color_White;
        self.iconImageName = iconName;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.checkButton];
        
        self.iconImageView.centerY = self.height / 2;
        self.iconImageView.left = 16;
        
        self.nameLabel.text = channelName;
        [self.nameLabel sizeToFit];
        self.nameLabel.centerY = self.iconImageView.centerY;
        self.nameLabel.left = self.iconImageView.right + 15;
        
        self.descLabel.text = description;
        [self.descLabel sizeToFit];
        self.descLabel.centerY = self.iconImageView.centerY;
        self.descLabel.right = SCREEN_WIDTH - 41;
        
        self.checkButton.centerY = self.iconImageView.centerY;
        self.checkButton.right = SCREEN_WIDTH - 16;
        
        self.userInteractionEnabled = YES;
        [self bk_whenTapped:^{
            [self handleCheckButton];
        }];
    }
    
    return self;
}

#pragma mark - Getters And Setters

- (UIImageView *)iconImageView {
    
    if ( !_iconImageView ) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 0, 0)];
        _iconImageView.image = [UIImage imageNamed:self.iconImageName];
        [_iconImageView sizeToFit];
    }
    
    return _iconImageView;
}

- (UILabel *)nameLabel {
    
    if ( !_nameLabel ) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _nameLabel.textColor = Color_Gray66;
        _nameLabel.font = FONT(14);
        _nameLabel.numberOfLines = 1;
    }
    
    return _nameLabel;
}

- (UILabel *)descLabel {
    
    if ( !_descLabel ) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _descLabel.textColor = Color_Gray66;
        _descLabel.font = FONT(12);
        _descLabel.numberOfLines = 1;
    }
    
    return _descLabel;
}

- (TTCheckButton *)checkButton {
    
    if ( !_checkButton ) {
        _checkButton = [[TTCheckButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20) imageNames:@[@"icon_cashier_unselected",@"icon_cashier_unselected",@"icon_cashier_selected"]];
        [_checkButton addTarget:self action:@selector(handleCheckButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _checkButton;
}

- (void)setDisabled:(BOOL)disabled {
    
    if ( _disabled == disabled ) {
        return;
    }
    
    _disabled = disabled;
    
    if ( disabled ) {
        
        self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_disabled", self.iconImageName]];
        [self.iconImageView sizeToFit];
        self.iconImageView.centerY = self.height / 2;
        
        self.nameLabel.textColor = Color_Gray209;
        
        self.descLabel.textColor = Color_Gray209;
        
        self.checkButton.enabled = NO;
        
    } else {
        
        self.iconImageView.image = [UIImage imageNamed:self.iconImageName];
        [self.iconImageView sizeToFit];
        self.iconImageView.centerY = self.height / 2;
        
        self.nameLabel.textColor = Color_Gray66;
        
        self.descLabel.textColor = Color_Gray66;
        
        self.checkButton.enabled = YES;
        
    }
    
}

- (BOOL)selected {
    
    return self.checkButton.selected;
    
}

- (void)setSelected:(BOOL)selected {
    
    self.checkButton.selected = selected;
    
}

#pragma mark - Event Response

- (void)handleCheckButton {
    
    if (self.disabled) {
        return;
    }
    
    self.checkButton.selected = !self.checkButton.isSelected;
    
    if ( [self.delegate respondsToSelector:@selector(payChannelView:didSelect:)]) {
        [self.delegate payChannelView:self didSelect:self.checkButton.selected];
    }
    
}

@end
