//
//  CertificatePopView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "CertificatePopView.h"
#import "IosLayoutDefine.h"
#import "CertificateContentView.h"
#import "TopBarView.h"
#import "LangCaptain.h"

@interface CertificatePopView() {
    CertificateContentView *contentView;
}

@end

@implementation CertificatePopView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    CGRect contentViewRect = CGRectMake(0, SCREEN_STATUS_BAR + SCREEN_TOPST_HEIGHT,SCREEN_WIDTH,SCREEN_HEIGHT);
    [contentView setFrame:contentViewRect];
}

- (void)initComponent {
    [self initTopBar];
    [self initContentView];
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)initTopBar{
    TopBarView *topBar = [[TopBarView alloc] init];
    
    [topBar setTitleName:[[LangCaptain getInstance] getLangByCode:@"CertificateManagement"] withMidButton:nil];
    [self addSubview:topBar];
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    CGPoint centerPoint = CGPointMake(SCREEN_TOPST_HEIGHT / 2, SCREEN_TOPST_HEIGHT / 2);
    CGRect imageRect = CGRectMake(0, 0, 20, 20);
    
    [leftButton setFrame:CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_TOPST_HEIGHT, SCREEN_TOPST_HEIGHT)];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:[ScreenAuotoSizeScale CGAutoMakeRect:imageRect]];
    [leftButton addSubview:leftView];
    [leftView setImage:[UIImage imageNamed:@"images/normal/reback.png"]];
    [leftView setCenter:centerPoint];
    
    [topBar addSubview:leftButton];
}

- (void)initContentView {
    contentView = [[CertificateContentView alloc] init];
    [self addSubview:contentView];
}

- (void)reback {
    [self removeFromSuperview];
}

@end
