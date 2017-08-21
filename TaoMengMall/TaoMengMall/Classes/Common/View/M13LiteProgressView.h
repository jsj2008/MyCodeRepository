//
//  M13LiteProgressView.h
//  BabyDaily
//
//  Created by marco on 10/20/16.
//  Copyright © 2016 marco. All rights reserved.
//
// Lite version for https://github.com/Marxon13/M13ProgressSuite/blob/master/Classes/ProgressViews/M13ProgressViewBorderedBar.m


#import <UIKit/UIKit.h>

typedef enum {
    M13ProgressViewBorderedBarCornerTypeSquare,
    M13ProgressViewBorderedBarCornerTypeRounded,
    M13ProgressViewBorderedBarCornerTypeCircle
} M13ProgressViewBorderedBarCornerType;

@interface M13LiteProgressView : UIView


@property (nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic, strong) UIColor *trackTintColor;

@property (nonatomic, assign) M13ProgressViewBorderedBarCornerType cornerType;
@property (nonatomic, assign) CGFloat cornerRadius;


/**The durations of animations in seconds.*/
@property (nonatomic, assign) CGFloat animationDuration;
/**The progress displayed to the user.*/
@property (nonatomic, assign) CGFloat progress;

- (id)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (id)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
