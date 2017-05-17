//
//  AutoLayoutView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ContentView.h"

@interface ContentView()

@end

@implementation ContentView

@synthesize isShow;

@synthesize hiddenButton;

- (id)init {
    if (self = [super init]) {
        self.isShow = true;
    }
    return self;
}

- (void)setContentViewHidden:(Boolean)isHidden {
//    self.isShow = !isHidden;
    NSLog(@"super setContentViewHidden");
}

- (void)destroy {
    
}

@end
