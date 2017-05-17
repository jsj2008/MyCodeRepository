//
//  LeftTradeContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LeftTradeContentView.h"

@implementation LeftTradeContentView

#pragma override
- (void)reloadPageData {
    [super reloadPageData];
}

- (void)pageUnSelect {
    [super pageUnSelect];
    [self removeListener];
}

- (void)pageSelect {
    [super pageSelect];
    [self addListener];
}

@end
