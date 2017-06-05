//
//  SDTopStatusView.m
//  SD
//
//  Created by LayZhang on 2017/5/31.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDTopStatusView.h"

@interface SDTopStatusView()

@property (nonatomic, weak) UIButton *normal;
@property (nonatomic, weak) UIButton *apply;
@property (nonatomic, weak) UIButton *refundAndOverdue;
@property (nonatomic, weak) UIButton *userPrivacy;
@property (nonatomic, weak) UIButton *userFeedBack;

@end

@implementation SDTopStatusView

- (instancetype)init {
    if (self = [super init]) {
        [self initCompnonent];
    }
    return self;
}

- (void)initCompnonent {
    self.backgroundColor = SDWhiteColor;
    UIButton *normal = [[UIButton alloc] init];
    [normal setImage:[UIImage imageNamed:@"help_normal"] forState:UIControlStateNormal];
    self.normal = normal;
    [self addSubview:normal];
    
    UIButton *apply = [[UIButton alloc] init];
    [apply setImage:[UIImage imageNamed:@"help_apply"] forState:UIControlStateNormal];
    self.apply = apply;
    [self addSubview:apply];
    
    UIButton *refundAndOverdue = [[UIButton alloc] init];
    [refundAndOverdue setImage:[UIImage imageNamed:@"help_refundAndOverdue"] forState:UIControlStateNormal];
    self.refundAndOverdue = refundAndOverdue;
    [self addSubview:refundAndOverdue];
    
    UIButton *userPrivacy = [[UIButton alloc] init];
    [userPrivacy setImage:[UIImage imageNamed:@"help_userPrivacy"] forState:UIControlStateNormal];
    self.userPrivacy = userPrivacy;
    [self addSubview:userPrivacy];
    
    UIButton *userFeedBack = [[UIButton alloc] init];
    [userFeedBack setImage:[UIImage imageNamed:@"help_userFeedBack"] forState:UIControlStateNormal];
    self.userFeedBack = userFeedBack;
    [self addSubview:userFeedBack];
    
    [self.normal addTarget:self action:@selector(clickSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.apply addTarget:self action:@selector(clickSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.refundAndOverdue addTarget:self action:@selector(clickSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.userPrivacy addTarget:self action:@selector(clickSender:) forControlEvents:UIControlEventTouchUpInside];
    [self.userFeedBack addTarget:self action:@selector(clickSender:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickSender:(id)sender {
    SDQuestionType type = SDQuestionTypeNormal;
    if (sender == self.normal) {
        type = SDQuestionTypeNormal;
    }
    if (sender == self.apply) {
        type = SDQuestionTypeApply;
    }
    if (sender == self.refundAndOverdue) {
        type = SDQuestionTypeRefundAndOverdue;
    }
    if (sender == self.userPrivacy) {
        type = SDQuestionTypeUserPrivacy;
    }
    if (sender == self.userFeedBack) {
        type = SDQuestionTypeUserFeedBack;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectAtIndex:)]) {
        [self.delegate didSelectAtIndex:type];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat totalHeight = SCREENWIDTH / 5 + 20 * SCALE;
    CGFloat totalWidth = SCREENWIDTH / 5;
    
    
    self.normal.frame           = CGRectMake(totalWidth * 0, 0, totalWidth, totalHeight);
    self.apply.frame            = CGRectMake(totalWidth * 1, 0, totalWidth, totalHeight);
    self.refundAndOverdue.frame = CGRectMake(totalWidth * 2, 0, totalWidth, totalHeight);
    self.userPrivacy.frame      = CGRectMake(totalWidth * 3, 0, totalWidth, totalHeight);
    self.userFeedBack.frame     = CGRectMake(totalWidth * 4, 0, totalWidth, totalHeight);
    
}


@end
