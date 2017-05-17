//
//  OrderPositionContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ContentView.h"

@interface OrderPositionContentView : ContentView

- (void)scroll;
+ (void)setScrollOrderID:(NSString *)orderID;

- (void)addListener;
- (void)removeListener;

@end
