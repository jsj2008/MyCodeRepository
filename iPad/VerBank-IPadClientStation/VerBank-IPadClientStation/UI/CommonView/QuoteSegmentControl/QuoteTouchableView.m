//
//  QuoteTouchableView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "QuoteTouchableView.h"

@interface QuoteTouchableView() {
    CGPoint beginPoint;
}

@end

@implementation QuoteTouchableView

@synthesize quoteView;

- (void)initContent {
    [self.quoteView.instrumentLabel                 setHidden:false];
    [self.quoteView.instrumentLabel                 setTextColor:[UIColor whiteColor]];
    [self.quoteView.instrumentLabel                 setBackgroundColor:[UIColor grayColor]];
    [self.quoteView.instrumentLabel                 setFont:[UIFont systemFontOfSize:12.0f]];
    
    [self.quoteView.leftSubview.buySellLabel        setTextAlignment:NSTextAlignmentLeft];
    [self.quoteView.leftSubview.buySellLabel        setFont:[UIFont systemFontOfSize:10.0f]];
    [self.quoteView.leftSubview.leftLabel           setFont:[UIFont systemFontOfSize:22.0f]];
    [self.quoteView.leftSubview.middleLabel         setFont:[UIFont systemFontOfSize:32.0f]];
    
    [self.quoteView.rightSubview.buySellLabel       setTextAlignment:NSTextAlignmentRight];
    [self.quoteView.rightSubview.buySellLabel       setFont:[UIFont systemFontOfSize:10.0f]];
    [self.quoteView.rightSubview.leftLabel          setFont:[UIFont systemFontOfSize:22.0f]];
    [self.quoteView.rightSubview.middleLabel        setFont:[UIFont systemFontOfSize:32.0f]];
    
    [self.quoteView.leftSubview.backgroundButton    setUserInteractionEnabled:false];
    [self.quoteView.rightSubview.backgroundButton   setUserInteractionEnabled:false];
    [self.quoteView.instrumentLabel                 setUserInteractionEnabled:true];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    beginPoint = [touch locationInView:self];
    [[self superview] bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - beginPoint.x;
    float dy = point.y - beginPoint.y;
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    float halfx = CGRectGetMidX(self.bounds);
    if(dx < 0) {
        newcenter.x = MAX(halfx,newcenter.x);
    } else {
        newcenter.x = MIN(self.superview.bounds.size.width-halfx,newcenter.x);
    }
    
    float halfy = CGRectGetMidY(self.bounds);
    if(dy < 0) {
        newcenter.y = MAX(newcenter.y,halfy);
    } else {
        newcenter.y = MIN(newcenter.y,self.superview.bounds.size.height - halfy);
    }
    self.center = newcenter;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
}

@end
