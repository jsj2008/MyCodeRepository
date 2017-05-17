//
//  OpenPositionContentView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"

@interface OpenPositionContentView : ContentView

// 跳到指定商品。。 部位汇总
+ (void)setSelectInstrument:(NSString *)instrument;
+ (void)setSelectTicket:(NSString *)ticket;

- (void)scroll;
- (void)addListener;
- (void)removeListener;

@end
