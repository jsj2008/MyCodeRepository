//
//  GifView.h
//  XiaoPa
//
//  Created by wzningjie on 2017/1/13.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MCGifAnimateState) {
    MCGifAnimateStateUndeterminated = 0,
    MCGifAnimateStateReady          = 1,
    MCGifAnimateStateAnimating      = 2,
    MCGifAnimateStatePause          = 3,
    MCGifAnimateStateStopped        = 4,
    MCGifAnimateStateFinished       = 5
};

@interface GifView : UIView{
    NSMutableArray *_frames;
    NSMutableArray *_frameDelayTimes;
    
    CGFloat _totalTime;
    CGFloat _width;
    CGFloat _height;
    
    BOOL _canAnimate;
}

@property(assign, nonatomic) NSUInteger repeatCount;
@property(assign, nonatomic, readonly) MCGifAnimateState state;

// the frame of MCGifView will determinated by gif resolution, but you can change it later.
- (instancetype)initWithGifData:(NSData*)gifData;

// initialize an empty MCGifView and prepare to populate a gif.
- (instancetype)initWithFrame:(CGRect)frame;

// you use this method to change gif you wan to dispaly and animate.
- (void)populateGifData:(NSData*)gifData shouldAutopaly:(BOOL)autoplay;


- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;
@end

