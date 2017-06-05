//
//  SDSignatureCheckView.m
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDSignatureCheckView.h"

@implementation SDSignatureCheckView

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self initContent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initContent];
    }
    return self;
}

- (void)initContent {
    UIButton *checkBoxButton = [[UIButton alloc] init];
    self.checkBox = checkBoxButton;
    [self addSubview:checkBoxButton];
    
    UILabel *checkLabel = [[UILabel alloc] init];
    checkLabel.textColor = FDColor(102, 102, 102);
    checkLabel.font = [UIFont systemFontOfSize:24 * SCALE];
    self.checkLabel = checkLabel;
    [self addSubview:checkLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    
    CGFloat checkBoxH = 30 * SCALE;
    
    CGSize checkBoxSize = CGSizeMake(checkBoxH, checkBoxH);
    CGPoint checkBoxCenter = CGPointMake(checkBoxH / 2, height / 2);
    [self.checkBox setSize:checkBoxSize];
    [self.checkBox setCenter:checkBoxCenter];
    
    CGFloat checkLabelx = checkBoxH + 18 * SCALE;
    CGRect checkLabelFrame = CGRectMake(checkLabelx, 0, width - checkLabelx, height);
    [self.checkLabel setFrame:checkLabelFrame];
    
}

#pragma mark - public
- (void)setIsSelect:(Boolean)isSelect {
    if (isSelect) {
        [self.checkBox setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateNormal];
    } else {
        [self.checkBox setImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    }
}

@end
