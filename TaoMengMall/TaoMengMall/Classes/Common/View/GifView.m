//
//  GifView.m
//  XiaoPa
//
//  Created by wzningjie on 2017/1/13.
//  Copyright © 2017年 marco. All rights reserved.
//

#import "GifView.h"
#import <ImageIO/ImageIO.h>
#import <QuartzCore/CoreAnimation.h>

#define kGifAnimationKey @"com.ocz.gifAnimation"

@implementation GifView


- (instancetype)initWithGifData:(NSData*)gifData
{
    if (self = [super init]) {
        _frames = [NSMutableArray array];
        _frameDelayTimes = [NSMutableArray array];
        _totalTime = 0;
        _canAnimate = NO;
        
        // default to animate without stop
        _repeatCount = NSUIntegerMax;
        
        if([self resolveGifData:gifData]){
            _state = MCGifAnimateStateReady;
            self.frame = CGRectMake(0, 0, _width, _height);
            self.layer.contents = [_frames objectAtIndex:0];
        }else
        {
            _state = MCGifAnimateStateUndeterminated;
            self.frame = CGRectZero;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _frames = [NSMutableArray array];
        _frameDelayTimes = [NSMutableArray array];
        _totalTime = 0;
        _canAnimate = NO;
        _state = MCGifAnimateStateUndeterminated;
        
        // default to animate without stop
        _repeatCount = NSUIntegerMax;
    }
    return self;
}

- (void)setRepeatCount:(NSUInteger)repeatCount
{
    if (_canAnimate) {
        _repeatCount = repeatCount;
    }else
        _repeatCount = NSUIntegerMax;
}

- (void)start
{
    if (_canAnimate) {
        
        // reset layer
        self.layer.speed = 1.0;
        self.layer.timeOffset = 0.0;
        self.layer.beginTime = 0.0;
        [self.layer removeAllAnimations];
        self.layer.contents = nil;
        
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        animation.keyTimes = _frameDelayTimes;
        animation.values = _frames;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.calculationMode = kCAAnimationDiscrete;
        animation.duration = _totalTime;
        animation.delegate = self;
        animation.repeatCount = _repeatCount;
        //animation.removedOnCompletion = NO;
        //animation.fillMode = kCAFillModeForwards;
        [self.layer addAnimation:animation forKey:kGifAnimationKey];
        
    }
}

- (void)stop
{
    if (_state == MCGifAnimateStateAnimating||_state == MCGifAnimateStatePause) {
        _state = MCGifAnimateStateStopped;
        self.layer.contents = [_frames objectAtIndex:0];
        [self.layer removeAllAnimations];
    }
}

- (void)pause
{
    if (_state == MCGifAnimateStateAnimating) {
        _state = MCGifAnimateStatePause;
        [self pauseLayer:self.layer];
    }
    
}

- (void)resume
{
    if (_state == MCGifAnimateStatePause) {
        _state = MCGifAnimateStateAnimating;
        [self resumeLayer:self.layer];
    }
}


- (void)populateGifData:(NSData*)gifData shouldAutopaly:(BOOL)autoplay
{
    // reset
    [self.layer removeAllAnimations];
    self.layer.contents = nil;
    [_frames removeAllObjects];
    [_frameDelayTimes removeAllObjects];
    _totalTime = 0;
    
    if([self resolveGifData:gifData]){
        _state = MCGifAnimateStateReady;
        self.layer.contents = [_frames objectAtIndex:0];
    }
    if (autoplay) {
        [self start];
    }
}


#pragma mark CAAnimation delegate methods
- (void)animationDidStart:(CAAnimation *)anim
{
    if (anim == [self.layer animationForKey:kGifAnimationKey]) {
        _state = MCGifAnimateStateAnimating;
    }
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        _state = MCGifAnimateStateFinished;
        self.layer.contents = [_frames objectAtIndex:0];
    }
    
}
#pragma mark private methods
// pause and resume support
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

// resolve gif information
- (BOOL)resolveGifData:(NSData*)data
{
    if (!data) {
        return NO;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    if (count == 0) {
        CFRelease(source);
        return NO;
    }else if (count == 1) {
        CGImageRef img = CGImageSourceCreateImageAtIndex(source, 0, NULL);
        [_frames addObject:(__bridge_transfer UIImage*)img];
        _canAnimate = NO;
    }else{
        NSMutableArray *times = [NSMutableArray arrayWithCapacity:3];
        for (size_t i = 0; i < count; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(source, i, NULL);
            [_frames addObject:(__bridge_transfer UIImage*)img];
            CGFloat frameDuration = [self frameDurationAtIndex:i source:source];
            [times addObject:[NSNumber numberWithFloat:frameDuration]];
            _totalTime += frameDuration;
        }
        CGFloat currentTime = 0;
        for (size_t i=0; i<count; i++) {
            float delay = currentTime/_totalTime;
            [_frameDelayTimes addObject:[NSNumber numberWithFloat:delay]];
            currentTime += [[times objectAtIndex:i]floatValue];
        }
        _canAnimate = YES;
    }
    [self populateFrameSize:source];
    CFRelease(source);
    return YES;
}

- (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source
{
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, NULL);
    NSDictionary *frameProperties = (__bridge NSDictionary*)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(__bridge NSString*) kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(__bridge NSString*)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }else
    {
        NSNumber *delayTimeProp = gifProperties[(__bridge NSString*)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}

- (void)populateFrameSize:(CGImageSourceRef)source
{
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    NSDictionary *frameProperties = (__bridge NSDictionary*)cfFrameProperties;
    
    NSNumber *width = frameProperties[(__bridge_transfer NSString*)kCGImagePropertyPixelWidth];_width = [width floatValue];
    NSNumber *height = frameProperties[(__bridge_transfer NSString*)kCGImagePropertyPixelHeight];_height = [height floatValue];
}

@end
