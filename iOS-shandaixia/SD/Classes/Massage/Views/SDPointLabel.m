//
//  SDPointLabel.m
//  SD
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDPointLabel.h"

#define PointTrueColor FDColor(70, 153, 255)
#define PointFalseColor FDColor(168, 168, 168)



@implementation SDPointLabel

- (instancetype)init {
    if (self = [super init]) {
        [self initContentView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initContentView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView {
    // pointImageView
    UIImageView *pointImageView = [[UIImageView alloc] init];
    self.pointImageView = pointImageView;
    [self addSubview:pointImageView];
    
    // contentLabel
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = ZLNormalFont(30 * SCALE);
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
}

#pragma mark - update constraints
- (void)updateConstraints {
    [super updateConstraints];
    __weak typeof (self) ws = self;
    [self.pointImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.centerY.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(18 * SCALE, 18 * SCALE));
    }];
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointImageView.mas_right).offset(20 * SCALE);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(ws.mas_height);
        make.width.mas_equalTo(ws.mas_width).offset(80 * SCALE);
    }];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - update status

- (void)setPointLabelStyle:(PointLabelStatus)pointStatus {
    switch (pointStatus) {
        case PointLabelTrue:
            self.pointImageView.backgroundColor = PointTrueColor;
            break;
        case PointLabelFalse:
            self.pointImageView.backgroundColor = PointFalseColor;
            break;
        default:
            break;
    }
    self.pointImageView.layer.cornerRadius = 10 * SCALE;
    self.pointImageView.clipsToBounds = YES;
}

@end
