//
//  TopBarView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/20.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TopBarView.h"
#import "IosLayoutDefine.h"
#import "ScreenAuotoSizeScale.h"
#import "CustomFont.h"

//#define Label_Width [ScreenAuotoSizeScale CGAutoMakeFloat:120]
//#define Label_Height [ScreenAuotoSizeScale CGAutoMakeFloat:20]

@interface TopBarView(){
    UILabel *_title;
    UIButton *_centerButton;
}

@end

@implementation TopBarView

- (id)init {
    if (self = [super init]) {
        if (IOS7_OR_LATER) {
            self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_TOPST_HEIGHT + SCREEN_STATUS_BAR);
        } else {
            self.frame = CGRectMake(0, SCREEN_STATUS_BAR, SCREEN_WIDTH, SCREEN_TOPST_HEIGHT);
        }
        [self addTitle:@"default"];
    }
    return self;
}


- (void)addTitle:(NSString *)title{
    _title = [[UILabel alloc] initWithFrame:CGRectZero];

    [_title setTextColor:[UIColor whiteColor]];
    [_title setText:title];
//    [_title setFont:[UIFont systemFontOfSize:20.0f]];
    [_title setFont:[CustomFont getCNHeavyWithSize:17.0f]];
    [_title setTextAlignment:NSTextAlignmentCenter];
    
    [self setBackgroundColor:[UIColor blackColor]];
    [self addSubview:_title];
}

- (void)setTitleName:(NSString *)title withMidButton:(UIButton *)btn{
    [_title setText:title];
    [_title sizeToFit];
    [_title setCenter:CGPointMake(SCREEN_WIDTH / 2,
                                  SCREEN_TOPST_HEIGHT / 2 + SCREEN_STATUS_BAR)];
    if (btn != nil) {
        CGRect frame = _title.frame;
        frame.origin.x = frame.origin.x + frame.size.width;
        frame.size.width = frame.size.height;
        [btn setFrame:frame];
        [self addSubview:btn];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ||
//        [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
//        [self setHidden:true];
//    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
//        [self setHidden:false];
//    }
}

@end
