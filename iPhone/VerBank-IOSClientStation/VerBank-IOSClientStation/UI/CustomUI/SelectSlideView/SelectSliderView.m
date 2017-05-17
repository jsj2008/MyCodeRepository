//
//  SelectSliderView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/6.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SelectSliderView.h"
#import "UIColor+CustomColor.h"
#import "CustomFont.h"

#define BeginPointX self.frame.size.width / 20
#define DefaultPointNumber 4
#define CircularRadius 1.5
#define stepViewRect CGRectMake(0, 0, 24, 12)

@interface SelectSliderView(){
    int positionCount;
    NSMutableArray *pointArray;
    UIView *stepView;
    UILabel *stepName;
    NSArray *_pointNameArray;
    
    Boolean touched;
    CGPoint beginPoint;
    
    int currentIndex;
    
}

@end

@implementation SelectSliderView

@synthesize delegate;

- (id)initWithPointArray:(NSArray *)pointNameArray frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor blackColor]];
        _pointNameArray = pointNameArray;
        positionCount = (int)[pointNameArray count];
        [self initPointArray];
        [self initStepViewRect];
        [self initLayout];
        touched = false;
        currentIndex = 0;
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor blackColor]];
        positionCount = DefaultPointNumber;
    }
    return self;
}

- (void)initPointArray{
    pointArray = [[NSMutableArray alloc] init];
    float beginPointX = BeginPointX;
    float distance = (self.frame.size.width - BeginPointX * 2) / (positionCount - 1);
    float yPosition = self.frame.size.height / 2;
    for (int i = 0 ; i < positionCount; i++) {
        CGPoint point = CGPointMake(beginPointX + distance * i, yPosition);
        [pointArray addObject:[NSValue valueWithCGPoint:point]];
    }
}

- (void)initStepViewRect{
    stepView = [[UIView alloc] initWithFrame:stepViewRect];
    [stepView setBackgroundColor:[UIColor blueSegmentColor]];
    stepView.layer.masksToBounds = YES;
    stepView.layer.cornerRadius = 5.0;
    [self addSubview:stepView];
    stepName = [[UILabel alloc] initWithFrame:stepViewRect];
    [stepName setText:[_pointNameArray objectAtIndex:0]];
    [stepName setTextColor:[UIColor whiteColor]];
    [stepName setTextAlignment:NSTextAlignmentCenter];
//    [stepName setFont:[UIFont systemFontOfSize:10.0f]];
    [stepName setFont:[CustomFont getCNNormalWithSize:10.0f]];
    [stepView addSubview:stepName];
}

- (void)initLayout{
    CGPoint startPoint = [[pointArray objectAtIndex:0] CGPointValue];
    [stepView setCenter:startPoint];
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
    
    CGPoint startPoint = [[pointArray objectAtIndex:0] CGPointValue];
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    for (int i = 0; i < positionCount ; i++) {
        CGPoint point = [[pointArray objectAtIndex:i] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    //连接上面定义的坐标点
    CGContextStrokePath(context);
}

- (void)drawCircular{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, CircularRadius + 0.5);
    CGContextSetRGBStrokeColor(context, 169.0 / 255.0, 170.0 / 255.0, 172.0 / 255.0, 1.0);
    
    for (int i = 0; i < positionCount ; i++) {
        CGPoint point = [[pointArray objectAtIndex:i] CGPointValue];
        CGRect rectangle = CGRectMake(point.x - CircularRadius, point.y - CircularRadius, CircularRadius *2, CircularRadius *2);
        CGContextAddEllipseInRect(context, rectangle);
    }
    
    CGContextStrokePath(context);
}

- (int)getCurrentIndex {
    return currentIndex;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    UITouch *touch = [touches anyObject];
    //    if(touch.view.frame.size.width <= 40){
    //        touched = true;
    //        beginPoint = [touch locationInView:self];
    //    } else {
    //        touched = false;
    //    }
    
    UITouch *touch = [touches anyObject];
    touched = true;
    beginPoint = [touch locationInView:self];
    CGPoint stepCenter = stepView.center;
    CGFloat startEdge = [[pointArray objectAtIndex:0] CGPointValue].x;
    CGFloat endEdge = [[pointArray lastObject] CGPointValue].x;
    
    if (beginPoint.x < startEdge) {
        stepCenter.x = startEdge;
    } else if (beginPoint.x > endEdge){
        stepCenter.x = endEdge;
    } else {
        stepCenter.x = beginPoint.x;
    }
    stepView.center = stepCenter;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (touched) {
        CGFloat startEdge = [[pointArray objectAtIndex:0] CGPointValue].x;
        CGFloat endEdge = [[pointArray lastObject] CGPointValue].x;
        
        UITouch *touch = [touches anyObject];
        CGPoint currentLocation = [touch locationInView:self];
        CGPoint stepCenter = stepView.center;
        
        if (currentLocation.x < startEdge) {
            stepCenter.x = startEdge;
        } else if (currentLocation.x > endEdge){
            stepCenter.x = endEdge;
        } else {
            stepCenter.x = currentLocation.x;
        }
        stepView.center = stepCenter;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touched) {
        int index = 0;
        CGFloat minDistance = 320;
        CGFloat currentX = stepView.center.x;
        for (int i = 0; i < positionCount; i++) {
            CGFloat pointX = [[pointArray objectAtIndex:i] CGPointValue].x;
            CGFloat currentDistance = fabs(pointX - currentX);
            if (minDistance > currentDistance) {
                minDistance = currentDistance;
                index = i;
            }
        }
        CGPoint stepCenter = stepView.center;
        stepCenter.x = [[pointArray objectAtIndex:index] CGPointValue].x;
        stepView.center = stepCenter;
        
        if (index != currentIndex) {
            currentIndex = index;
            [stepName setText:[_pointNameArray objectAtIndex:currentIndex]];
            if ([delegate respondsToSelector:@selector(slideSelectChanged:)]) {
                [delegate slideSelectChanged:index];
            }
        }
        touched = false;
    }
}



@end