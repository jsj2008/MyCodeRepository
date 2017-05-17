//
//  CustomPageDelegate.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomPageView;

@protocol CustomPageViewDataSourceProtocol <NSObject>

//- (NSUInteger)countOfPageViews;
- (CGFloat)topTapTitleHeightAtPageView:(CustomPageView *)pageView;
- (NSArray *)arrayOfCustomPageViewAtPageView:(CustomPageView *)pageView;

- (Boolean)scrollEnable;

@end

@protocol CustomPageViewActionProtocol <NSObject>

- (void)pageView:(CustomPageView *)pageView didChangePageAtIndex:(NSUInteger)index;

@end

