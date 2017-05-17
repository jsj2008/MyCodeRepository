//
//  FreezeView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"

@interface QuoteListContentView : ContentView

- (void)reloadData;

- (void)autoLandscape;
- (void)autoPortrait;

// 不想這麼加
- (void)portrait:(int)state;

- (void)addListener;
- (void)removeListener;

@end
