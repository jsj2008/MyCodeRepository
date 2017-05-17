//
//  AutoLayoutView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/24.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AutoLayout.h"

@interface ContentView : UIView

@property UIButton *hiddenButton;

@property Boolean isShow;

// delay setHidden
- (void)setContentViewHidden:(Boolean)isHidden;

- (void)destroy;

@end
