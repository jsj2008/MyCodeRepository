//
//  TopStatusView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TopContentView.h"
#import "IOSLayoutDefine.h"
#import "PhonePinChecker.h"
#import "LayoutCenter.h"

@interface TopContentView()

@end

@implementation TopContentView

@synthesize topStatusBarView;

- (id)init {
    if (self = [super init]) {
        [self initComponent];
        [self addAllViews];
    }
    return self;
}

- (void)initComponent {
    self.topStatusBarView = [TopStatusBarView newInstance];
}

- (void)addAllViews {
    [self addSubview:topStatusBarView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect topStatusBarViewRect = self.bounds;
    topStatusBarViewRect.origin.y += SCREEN_STATUS_BAR;
    topStatusBarViewRect.size.height -= SCREEN_STATUS_BAR;
    [topStatusBarView setFrame:topStatusBarViewRect];
//    [topStatusBarView setFrame:self.bounds];
}

- (void)resetPhonePinState {
    Boolean needInputPhonePin = [[PhonePinChecker getInstance] checkIsneedputPhonePin];
    if (needInputPhonePin) {
        [self.topStatusBarView.rightButton setImage:[UIImage imageNamed:@"images/normal/personal.png"] forState:UIControlStateNormal];
    } else {
        [self.topStatusBarView.rightButton  setImage:[UIImage imageNamed:@"images/normal/personalwhite.png"] forState:UIControlStateNormal];
    }
}

- (void)dealloc {

}

@end
