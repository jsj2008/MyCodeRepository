//
//  SelectSliderView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectSlideEvent <NSObject>

- (void)slideSelectChanged:(int)index;

@end

@interface SelectSliderView : UIView

- (id)initWithPointArray:(NSArray *)pointNameArray frame:(CGRect)frame;

- (int)getCurrentIndex;

@property (nonatomic, retain)id<SelectSlideEvent> delegate;

@end
