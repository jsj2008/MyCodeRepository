//
//  UserInputView.m
//  XiaoPa
//
//  Created by wzningjie on 2016/11/21.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "UserInputView.h"

@interface UserInputView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation UserInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self render];
    }
    return self;
}


- (void)setName:(NSString *)name andValue:(NSString *)value{
    self.titleLabel.text = name;
    [self.titleLabel sizeToFit];
    self.titleLabel.left = 10;
    self.titleLabel.centerY = self.height / 2.0f;
    self.valueLabel.text = value;
    [self.valueLabel sizeToFit];
    self.valueLabel.centerY = self.titleLabel.centerY;
    self.valueLabel.left = 90;
}

- (void)render{
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
    [self addSubview:self.line];
    [self addSubview:self.moreImageView];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(14);
        label.textColor = Color_Gray(159);
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = FONT(14);
        label.textColor = Color_Gray42;
        _valueLabel = label;
    }
    return _valueLabel;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, LINE_WIDTH)];
        view.backgroundColor = Color_Gray224;
        view.bottom = self.height;
        _line = view;
    }
    return _line;
}

- (UIImageView *)moreImageView {
    
    if ( !_moreImageView ) {
        _moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
        _moreImageView.image = [UIImage imageNamed:@"icon_cellMore"];
        _moreImageView.centerY = self.height / 2.0f;
        _moreImageView.right = self.width - 5;
    }
    
    return _moreImageView;
}

@end
