//
//  M13LiteProgressView.m
//  BabyDaily
//
//  Created by marco on 10/20/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "M13LiteProgressView.h"

@interface M13LiteProgressView ()
/**The start progress for the progress animation.*/
@property (nonatomic, assign) CGFloat animationFromValue;
/**The end progress for the progress animation.*/
@property (nonatomic, assign) CGFloat animationToValue;
/**The start time interval for the animaiton.*/
@property (nonatomic, assign) CFTimeInterval animationStartTime;
/**Link to the display to keep animations in sync.*/
@property (nonatomic, strong) CADisplayLink *displayLink;

/**The layer that displays progress in the progress bar.*/
@property (nonatomic, retain) CAShapeLayer *trackLayer;

/**The background layer that displays the border.*/
@property (nonatomic, retain) CAShapeLayer *progressLayer;


@end

@implementation M13LiteProgressView

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    //Set own background color
    self.backgroundColor = [UIColor clearColor];
    
    //Set defauts
    self.animationDuration = 1.0;

    _cornerRadius = 3.0;

    _cornerType = M13ProgressViewBorderedBarCornerTypeSquare;
    
    //Set default colors
    self.trackTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    self.progressTintColor = [UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0];
    
    //trackLayer
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.strokeColor = self.trackTintColor.CGColor;
    _trackLayer.fillColor = self.trackTintColor.CGColor;
    [self.layer addSublayer:_trackLayer];
    
    //progressLayer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.strokeColor = self.progressTintColor.CGColor;
    _progressLayer.fillColor = self.progressTintColor.CGColor;
    [self.layer addSublayer:_progressLayer];
    
    //Layout
    [self layoutSubviews];
}

#pragma mark Appearance

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    _trackLayer.fillColor = _trackTintColor.CGColor;
    _trackLayer.strokeColor = _trackTintColor.CGColor;
    [self setNeedsDisplay];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    _progressLayer.fillColor = _progressTintColor.CGColor;
    _progressLayer.strokeColor = _progressTintColor.CGColor;
    [self setNeedsDisplay];
}


- (void)setCornerType:(M13ProgressViewBorderedBarCornerType)cornerType
{
    _cornerType = cornerType;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

#pragma mark Actions

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    if (animated == NO) {
        if (_displayLink) {
            //Kill running animations
            [_displayLink invalidate];
            _displayLink = nil;
        }
        _progress = progress;
        [self setNeedsDisplay];
    } else {
        _animationStartTime = CACurrentMediaTime();
        _animationFromValue = self.progress;
        _animationToValue = progress;
        if (!_displayLink) {
            //Create and setup the display link
            [self.displayLink invalidate];
            self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateTrack:)];
            [self.displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
        } /*else {
           //Reuse the current display link
           }*/
    }
}

- (void)animateTrack:(CADisplayLink *)displayLink
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat dt = (displayLink.timestamp - self.animationStartTime) / self.animationDuration;
        if (dt >= 1.0) {
            //Order is important! Otherwise concurrency will cause errors, because setProgress: will detect an animation in progress and try to stop it by itself. Once over one, set to actual progress amount. Animation is over.
            [self.displayLink invalidate];
            self.displayLink = nil;
            [self setNeedsDisplay];
            return;
        }
        
        //Set progress
        _progress = self.animationFromValue + dt * (self.animationToValue - self.animationFromValue);
        [self setNeedsDisplay];
        
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //Set the background layer size
    _progressLayer.frame = self.bounds;
    _trackLayer.frame = self.bounds;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
}

#pragma mark Drawing

- (void)drawRect:(CGRect)rect
{
    [self drawTrack];
    [self drawProgress];
}

- (void)drawTrack
{
    //Create the path to stroke
    //Calculate the corner radius
    CGFloat cornerRadius = 0;
    if (_cornerType == M13ProgressViewBorderedBarCornerTypeRounded) {
        cornerRadius = _cornerRadius;
    } else if (_cornerType == M13ProgressViewBorderedBarCornerTypeCircle) {
        cornerRadius = self.bounds.size.height;
    }
    
    //Draw the path
    CGRect rect = CGRectMake(.0, .0, self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path;
    if (_cornerType == M13ProgressViewBorderedBarCornerTypeSquare) {
        //Having a 0 corner radius does not display properly since the rect displays like it is not closed.
        path = [UIBezierPath bezierPathWithRect:rect];
    } else {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];;
    }
    _trackLayer.path = path.CGPath;
}

- (void)drawProgress
{
    
    //Calculate the corner radius
    CGFloat cornerRadius = 0;
    if (_cornerType == M13ProgressViewBorderedBarCornerTypeRounded) {
        cornerRadius = _cornerRadius;
    } else if (_cornerType == M13ProgressViewBorderedBarCornerTypeCircle) {
  
        cornerRadius = self.bounds.size.height;
    }
    
    //Draw the path
    CGFloat minProgress = 2*cornerRadius/self.bounds.size.width;
    CGFloat progress = minProgress;
    if (self.progress > progress) {
        progress = self.progress;
    }
    CGRect rect = CGRectMake(0,0, (self.bounds.size.width - 0) * progress, self.bounds.size.height - 0);
    UIBezierPath *path ;
    if (_cornerType == M13ProgressViewBorderedBarCornerTypeSquare) {
        //Having a 0 corner radius does not display properly since the rect displays like it is not closed.
        path = [UIBezierPath bezierPathWithRect:rect];
    } else {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];;
    }
    [_progressLayer setPath:path.CGPath];
}
@end
