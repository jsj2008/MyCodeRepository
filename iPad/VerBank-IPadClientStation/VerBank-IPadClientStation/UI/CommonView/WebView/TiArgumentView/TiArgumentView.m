//
//  TiArgumentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiArgumentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"
#import "RSIContentView.h"
#import "MACDContentView.h"
#import "KDJContentView.h"
#import "MAContentView.h"
#import "BollingerBandContentView.h"

@interface TiArgumentView() {
//    TiArgumentConfig *_config;
}

@end

@implementation TiArgumentView

@synthesize contentView;
@synthesize viewType;

@synthesize backButton = _backButton;
@synthesize commitButton = _commitButton;
@synthesize resetButton = _resetButton;

- (void)initContent {
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [_backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"]
                 forState:UIControlStateNormal];
    [_commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Commit"]
                   forState:UIControlStateNormal];
    [_resetButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ResetArgument"]
                  forState:UIControlStateNormal];
    
    [_backButton setTintColor:[UIColor whiteColor]];
    [_commitButton setTintColor:[UIColor whiteColor]];
    [_resetButton setTintColor:[UIColor whiteColor]];
    
    [self setBackgroundColor:[UIColor blackColor ]];
}

- (void)showTiArgumentViewWithType:(id)type withTiArgumentConfig:(TiArgumentConfig *)config withIndex:(int)index{
    self.viewType = type;
    [self.contentView removeFromSuperview];
    if ([type isEqualToString:@"ma"]) {
        self.contentView = [MAContentView newInstance];
    } else if ([type isEqualToString:@"rsi"]) {
        self.contentView = [RSIContentView newInstance];
    } else if ([type isEqualToString:@"kdj"]) {
        self.contentView = [KDJContentView newInstance];
    } else if ([type isEqualToString:@"macd"]) {
        self.contentView = [MACDContentView newInstance];
    } else if ([type isEqualToString:@"bollingerBand"]) {
        self.contentView = [BollingerBandContentView newInstance];
    }
    
    [contentView setTiArgumentConfig:config withIndex:index];
    [self addSubview:contentView];
    [self setHidden:false];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    frame.origin.y = 30;
    frame.size.height -= 60;
    [contentView setFrame:frame];
}

@end
