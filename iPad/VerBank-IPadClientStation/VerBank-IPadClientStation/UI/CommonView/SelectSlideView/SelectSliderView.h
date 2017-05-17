//
//  SelectSliderView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntervalDefine.h"

@protocol SelectSlideEvent <NSObject>

- (void)slideSelectChanged:(int)index;

//- (NSArray *)getPointNameArray;

@end

@interface SelectSliderView : UIView

- (int)getCurrentIndex;
- (void)setPointNameArray:(NSArray *)pointNameArray;

@property (nonatomic, retain)id<SelectSlideEvent> delegate;

@end
