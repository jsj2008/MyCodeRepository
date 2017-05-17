//
//  TopStatusView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "TopStatusBarView.h"

@interface TopContentView : ContentView

@property (nonatomic, strong) TopStatusBarView *topStatusBarView;

- (void)resetPhonePinState;

@end
