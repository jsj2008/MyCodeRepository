//
//  LHSlideView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/20.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LHSlideView.h"
#import "UIColor+CustomColor.h"
#import "ScreenAuotoSizeScale.h"

#define CircularRadius 1.5
#define stepViewRect CGRectMake(0, 0, 5, 20)
#define DefaultFrom 0
#define DefaultTo 100

#define GrayColor [UIColor colorWithRed:169.0 / 255.0 green:170.0 / 255.0 blue:172.0 / 255.0 alpha:1.0]

@interface LHSlideView(){
    CGPoint startPoint;
    CGPoint endPoint;
    
    UIView *stepView;
    //    int _from;
    //    int _to;
    double lineLength;
    
    double _percent;
}

@end

@implementation LHSlideView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        //        [self initLineWithFrame:frame];
        //        [self initLineWithFrame:self.frame];
        //        [self initStepView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor clearColor]];
        //        [self initLineWithFrame:self.frame];
        //        [self initLineWithFrame:self.frame];
        //        [self initStepView];
    }
    return self;
}

- (void)layoutSubviews {
    
    // 长度需要 载入后才
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self initLineWithFrame:self.frame];
    [self initStepView];
    //    [stepView setCenter:startPoint];
    [self updateUI];
}

- (void)initLineWithFrame:(CGRect)frame{
    
    //    _from = DefaultFrom;
    //    _to = DefaultTo;
    
    startPoint = CGPointMake(frame.size.width / 15, frame.size.height / 2);
    endPoint = CGPointMake(frame.size.width / 15 * 14, frame.size.height / 2);
    lineLength = endPoint.x - startPoint.x;
    
    UILabel *lLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    UILabel *hLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [lLabel setText:@"L"];
    [hLabel setText:@"H"];
    [lLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:[ScreenAuotoSizeScale CGAutoMakeFloat:12.0f]]];
    [hLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:[ScreenAuotoSizeScale CGAutoMakeFloat:12.0f]]];
    [lLabel sizeToFit];
    [hLabel sizeToFit];
    [lLabel setTextColor:GrayColor];
    [hLabel setTextColor:GrayColor];
    CGPoint lCenterPoint = CGPointMake(lLabel.frame.size.width / 2, frame.size.height / 2);
    CGPoint hCenterPoint = CGPointMake(frame.size.width - lLabel.frame.size.width / 2, frame.size.height / 2);
    [lLabel setCenter:lCenterPoint];
    [hLabel setCenter:hCenterPoint];
    [self addSubview:lLabel];
    [self addSubview:hLabel];
    
}

- (void)initStepView{
    stepView = [[UIView alloc] initWithFrame:stepViewRect];
    [stepView setBackgroundColor:[UIColor blueSegmentColor]];
    stepView.layer.masksToBounds = YES;
    stepView.layer.cornerRadius = 2.0;
    [stepView setCenter:startPoint];
    [self addSubview:stepView];
}

- (void)drawRect:(CGRect)rect{
    [self drawLine];
    [self drawCircular];
}

- (void)drawLine{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    
    //设置颜色
    CGContextSetRGBStrokeColor(context, 169.0 / 255.0, 170.0 / 255.0, 172.0 / 255.0, 1.0);
    //开始一个起始路径
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    //连接上面定义的坐标点
    CGContextStrokePath(context);
}

- (void)drawCircular{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, CircularRadius + 0.5);
    CGContextSetRGBStrokeColor(context, 169.0 / 255.0, 170.0 / 255.0, 172.0 / 255.0, 1.0);
    
    CGRect startRect = CGRectMake(startPoint.x - CircularRadius, startPoint.y - CircularRadius, CircularRadius *2, CircularRadius *2);
    CGRect endRect = CGRectMake(endPoint.x - CircularRadius, endPoint.y - CircularRadius, CircularRadius *2, CircularRadius *2);
    CGContextAddEllipseInRect(context, startRect);
    CGContextAddEllipseInRect(context, endRect);
    
    CGContextStrokePath(context);
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//
//    CGPoint beginPoint = [touch locationInView:self];
//    CGPoint stepCenter = stepView.center;
//    CGFloat startEdge = startPoint.x;
//    CGFloat endEdge = endPoint.x;
//
//    if (beginPoint.x < startEdge) {
//        stepCenter.x = startEdge;
//    } else if (beginPoint.x > endEdge){
//        stepCenter.x = endEdge;
//    } else {
//        stepCenter.x = beginPoint.x;
//    }
//    stepView.center = stepCenter;
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    CGFloat startEdge = startPoint.x;
//    CGFloat endEdge = endPoint.x;
//
//    UITouch *touch = [touches anyObject];
//    CGPoint currentLocation = [touch locationInView:self];
//    CGPoint stepCenter = stepView.center;
//
//    if (currentLocation.x < startEdge) {
//        stepCenter.x = startEdge;
//    } else if (currentLocation.x > endEdge){
//        stepCenter.x = endEdge;
//    } else {
//        stepCenter.x = currentLocation.x;
//    }
//    stepView.center = stepCenter;
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    //    NSLog(@"%d", [self getCurrentValue]);
//}

#pragma updateFunc

- (void)updateCurrentPercent:(double)percent {
    //    CGPoint stepCenter = stepView.center;
    //    stepCenter.x = startPoint.x + lineLength * percent;
    //    [stepView setCenter:stepCenter];
    _percent = percent;
    [self updateUI];
}

- (void)updateUI {
    CGPoint stepCenter = stepView.center;
    stepCenter.x = startPoint.x + lineLength * _percent;
    [stepView setCenter:stepCenter];
}

- (void)dealloc {
    stepView  = nil;
}

//#pragma public func
//
//- (void)setRangeFrom:(int)from to:(int)end{
//    _from = from;
//    _to = end;
//}
//
//- (int)getCurrentValue {
//    double mainLength = endPoint.x - startPoint.x;
//    double currentLength = stepView.center.x - startPoint.x;
//    return (int)((_to - _from) * (currentLength / mainLength) + _from);
//}

@end
