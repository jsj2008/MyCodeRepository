//
//  BackgoundContentView.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/3.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundStatusEnum.h"
#import "LayoutContentView.h"

typedef NS_ENUM(NSUInteger, MainViewStyle) {
    MainViewStyleBig        = 0,
    MainViewStyleMiddle     = 1,
    MainViewStyleSmall      = 2,
    MainViewStyleHalf       = 3,
    MainViewStyleFullScreen = 4,
};

@interface BackgoundContentView : UIView {
    LayoutContentView *contentView;
}

@property CurrentScreenStatus status;
@property NSArray *contentArray;

- (void)openView;
- (void)closeView;

- (void)setStyle:(MainViewStyle)style;
//- (id)initWithStyle:(MainViewStyle)style;

//- (void)addListener;

@end
