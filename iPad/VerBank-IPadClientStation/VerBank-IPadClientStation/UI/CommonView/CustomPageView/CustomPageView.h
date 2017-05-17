//
//  CustomPageView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/25.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomPageDelegate.h"

extern const CGFloat leftEdge;
extern const CGFloat middleEdge;

@class CustomPageView;

@interface CustomPageView : UIView

//- (void)setPageViews:(NSArray *)viewArray;

@property (nonatomic, weak) id<CustomPageViewDataSourceProtocol> sourceDelegate;
@property (nonatomic, weak) id<CustomPageViewActionProtocol> actionDelegate;

//- (void)setDataSourceDelegate:(id<CustomPageViewProtocol>) sourceDelegate;
@property (nonatomic) NSArray *pageViewArray;
//@property NSArray *pageViewArray;

- (void)setCurrentPage:(NSUInteger)index;
- (void)reclickCurrentPage;
//- (void)resetTitle;

- (void)removeAllListener;


@end
