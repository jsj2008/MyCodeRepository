//
//  LayoutCenter.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LayoutCenter.h"

static LayoutCenter *instance = nil;

@implementation LayoutCenter

@synthesize backgroundLayoutCenter;
@synthesize mainViewLayoutCenter;
@synthesize quoteChartLayoutCenter;

+ (LayoutCenter *)getInstance {
    if (instance == nil) {
        instance = [[LayoutCenter alloc] init];
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.mainViewLayoutCenter   = [[MainViewLayoutCenter alloc] init];
        self.backgroundLayoutCenter = [[BackgroundLayoutCenter alloc] init];
        self.quoteChartLayoutCenter = [[QuoteChartLayoutCenter alloc] init];
    }
    return self;
}

- (void)updateLayout {
    [self.mainViewLayoutCenter changeState];
}

- (void)updateLayoutAfterRotation {
    [self.mainViewLayoutCenter.bottomContentView reclickPageView];
    [self.backgroundLayoutCenter resetLayout];
}

- (void)destroy {
//    self.mainViewLayoutCenter = nil;
//    self.backgroundLayoutCenter = nil;
//    self.quoteChartLayoutCenter= nil;
    instance = nil;
}

- (void)dealloc {
    
}

@end
