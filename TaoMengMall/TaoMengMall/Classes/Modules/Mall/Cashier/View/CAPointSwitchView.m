//
//  CAPointSwitchView.m
//  YouCai
//
//  Created by marco on 5/29/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CAPointSwitchView.h"

@interface CAPointSwitchView ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UISwitch *pointSwitch;

@property (nonatomic, strong) NSString *iconImageName;

@end


@implementation CAPointSwitchView

- (instancetype)initWithFrame:(CGRect)frame
                     iconName:(NSString*)iconName
                  channelName:(NSString *)channelName
                  description:(NSString *)description
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = Color_White;
        self.iconImageName = iconName;
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.pointSwitch];
        
        self.iconImageView.centerY = self.height / 2;
        self.iconImageView.left = 16;
        
        self.nameLabel.text = channelName;
        [self.nameLabel sizeToFit];
        self.nameLabel.centerY = self.iconImageView.centerY;
        self.nameLabel.left = self.iconImageView.right + 15;
        
        self.descLabel.text = description;
        [self.descLabel sizeToFit];
        self.descLabel.centerY = self.iconImageView.centerY;
        self.descLabel.left = self.nameLabel.right + 10;

        self.pointSwitch.centerY = self.iconImageView.centerY;
        self.pointSwitch.right = SCREEN_WIDTH - 16;
    }
    return self;
}


- (BOOL)selected
{
    _selected = self.pointSwitch.on;
    return _selected;
}

- (void)setDisabled:(BOOL)disabled
{
    _disabled = disabled;
    self.pointSwitch.enabled = !disabled;
}

- (void)setBalance:(NSInteger)balance
{
    _balance = balance;
    self.descLabel.text = [NSString stringWithFormat:@"(现有积分%ld)",balance];
    [self.descLabel sizeToFit];
}

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

- (UISwitch *)pointSwitch
{
    if (!_pointSwitch) {
        UISwitch *_switch = [[UISwitch alloc]init];
        [_switch addTarget:self action:@selector(handlePointSwitich) forControlEvents:UIControlEventValueChanged];
        _pointSwitch = _switch;
    }
    return _pointSwitch;
}

#pragma mark - actions
- (void)handlePointSwitich
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pointSwitch:didOn:)]) {
        [self.delegate pointSwitch:self didOn:self.pointSwitch.on];
    }
}
@end
