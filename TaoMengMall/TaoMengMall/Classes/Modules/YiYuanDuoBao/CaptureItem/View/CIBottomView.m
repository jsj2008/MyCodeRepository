//
//  CIBottomView.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/17.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "CIBottomView.h"

@interface CIBottomView ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;
@end

@implementation CIBottomView

- (instancetype)init{
    if (self = [super init]) {
        [self render];
    }
    return self;
}

- (void)render{
    self.width = SCREEN_WIDTH;
    self.height = 49;
    self.left = 0;
    self.bottom = SCREEN_HEIGHT;
    [self addSubview:self.label];
    [self addSubview:self.button];
}

- (UILabel *)label{
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = Color_Gray153;
        label.font = FONT(16);
        _label = label;
    }
    return _label;
}

- (UIButton *)button{
    if (!_button) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 124, 40)];
        button.centerY = self.height / 2.0f;
        button.right = self.width - 12;
        button.backgroundColor = RGB(225, 216, 86);
        [button setTitle:@"立刻前往" forState:UIControlStateNormal];
        button.titleLabel.font = FONT(16);
        [button setTitleColor:Color_Gray42 forState:UIControlStateNormal];
        button.layer.cornerRadius = 1;
        button.layer.borderColor = Color_Gray42.CGColor;
        weakify(self);
        [button bk_whenTapped:^{
            strongify(self);
            [[TTNavigationService sharedService] openUrl:self.model.link];
        }];
        _button = button;
    }
    return _button;
}

- (void)setModel:(CIItemButtonModel *)model
{
    _model = model;
    self.label.text = model.desc;
    [self.label sizeToFit];
    self.label.left = 20;
    self.label.centerY = self.height / 2.0f;
    
    self.hidden = !model;
}
@end
