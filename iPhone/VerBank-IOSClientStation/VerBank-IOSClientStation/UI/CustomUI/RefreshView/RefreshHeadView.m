//
//  RefreshHeadView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/15.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "RefreshHeadView.h"
#import "UIView+RefreshExtension.h"
#import "LangCaptain.h"

@interface RefreshHeadView() {
    Boolean _hasLayoutedForManuallyRefreshing;
}

@end

@implementation RefreshHeadView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textForNormalState = [[LangCaptain getInstance] getLangByCode:@"PushRefresh"];
        self.stateIndicatorViewNormalTransformAngle = 0;
        self.stateIndicatorViewWillRefreshStateTransformAngle = M_PI;
        [self setRefreshState:SDRefreshViewStateNormal];
    }
    return self;
}

- (CGFloat)yOfCenterPoint {
    //    if (self.isManuallyRefreshing && self.isEffectedByNavigationController && SDRefreshViewMethodIOS7) {
    //        return - (self.sd_height * 0.5 + self.originalEdgeInsets.top - SDKNavigationBarHeight);
    //    }
    return - (self.refreshViewHeight * 0.5);
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.center = CGPointMake(self.scrollView.refreshViewWidth * 0.5, [self yOfCenterPoint]);
    
    // 手动刷新
    if (self.isManuallyRefreshing && !_hasLayoutedForManuallyRefreshing && self.scrollView.contentInset.top > 0) {
        self.activityIndicatorView.hidden = NO;
        
        // 模拟下拉操作
        CGPoint temp = self.scrollView.contentOffset;
        temp.y -= self.refreshViewHeight * 2;
        self.scrollView.contentOffset = temp; // 触发准备刷新
        temp.y += self.refreshViewWidth;
        self.scrollView.contentOffset = temp; // 触发刷新
        
        _hasLayoutedForManuallyRefreshing = YES;
    } else {
        self.activityIndicatorView.hidden = !self.isManuallyRefreshing;
    }
}

- (void)beginRefreshing {
    self.isManuallyRefreshing = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:SDRefreshViewObservingkeyPath] || self.refreshState == SDRefreshViewStateRefreshing) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    CGFloat criticalY = -self.refreshViewHeight - self.scrollView.contentInset.top;
    
    // 只有在 y<=0 以及 scrollview的高度不为0 时才判断
    if ((y > 0) || (self.scrollView.bounds.size.height == 0)) return;
    
    // 触发SDRefreshViewStateRefreshing状态
    if (y <= criticalY && (self.refreshState == SDRefreshViewStateWillRefresh) && !self.scrollView.isDragging) {
        [self setRefreshState:SDRefreshViewStateRefreshing];
        return;
    }
    
    // 触发SDRefreshViewStateWillRefresh状态
    if (y < criticalY && (SDRefreshViewStateNormal == self.refreshState)) {
        [self setRefreshState:SDRefreshViewStateWillRefresh];
        return;
    }
    
    if (y > criticalY && self.scrollView.isDragging && (SDRefreshViewStateNormal != self.refreshState)) {
        [self setRefreshState:SDRefreshViewStateNormal];
    }
}

@end
