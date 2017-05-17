//
//  LayoutCenter.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/4.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewLayoutCenter.h"
#import "BackgroundLayoutCenter.h"
#import "QuoteChartLayoutCenter.h"

@interface LayoutCenter : NSObject

@property MainViewLayoutCenter      *mainViewLayoutCenter;
@property BackgroundLayoutCenter    *backgroundLayoutCenter;
@property QuoteChartLayoutCenter    *quoteChartLayoutCenter;

+ (LayoutCenter *)getInstance;

- (void)updateLayout;
- (void)updateLayoutAfterRotation;

- (void)destroy;

@end
