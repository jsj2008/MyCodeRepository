//
//  ITMarkView.h
//  FlyLantern
//
//  Created by marco on 12/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ITMarkView;

@protocol ITMarkViewDelegate <NSObject>

- (void)rateViewValueChanged:(ITMarkView*)rateView;

@end


@interface ITMarkView : UIView
@property (nonatomic, weak) id<ITMarkViewDelegate> delegate;
@property (nonatomic, assign) CGFloat mark;
@property (nonatomic, assign) CGFloat markWidth;
@property (nonatomic, assign) CGFloat labelFont;
@property (nonatomic, assign) BOOL showMark;

@end
