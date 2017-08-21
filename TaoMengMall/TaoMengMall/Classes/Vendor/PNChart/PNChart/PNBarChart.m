//
//  PNBarChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNBarChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"

@interface PNBarChart () {
    NSMutableArray *_xChartLabels;
    NSMutableArray *_yChartLabels;
    UIView *_yMarginView;
    CGFloat _originX;
    CGPoint _startPoint;
    CGFloat _startPX;
}
@property (nonatomic) CGFloat springXLabelWidth;

- (UIColor *)barColorAtIndex:(NSUInteger)index;

@end

@implementation PNBarChart

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupDefaultValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupDefaultValues];
    }
    
    return self;
}

- (void)setupDefaultValues
{
    [super setupDefaultValues];
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds   = YES;
    _showLabel           = YES;
    _barBackgroundColor  = PNLightGrey;
    _labelTextColor      = [UIColor grayColor];
    _labelFont           = [UIFont systemFontOfSize:11.0f];
    _xChartLabels        = [NSMutableArray array];
    _yChartLabels        = [NSMutableArray array];
    _bars                = [NSMutableArray array];
    _xLabelSkip          = 1;
    _yLabelSum           = 4;
    _labelMarginTop      = 0;
    _chartMarginLeft     = 25.0;
    _chartMarginRight    = 25.0;
    _chartMarginTop      = 25.0;
    _chartMarginBottom   = 25.0;
    _barRadius           = 2.0;
    _showChartBorder     = NO;
    _chartBorderColor    = PNLightGrey;
    _showLevelLine       = NO;
    _yChartLabelWidth    = 18;
    _rotateForXAxisText  = false;
    _isGradientShow      = YES;
    _isShowNumbers       = YES;
    _yLabelPrefix        = @"";
    _yLabelSuffix        = @"";
    _yLabelFormatter = ^(CGFloat yValue){
        return [NSString stringWithFormat:@"%1.f",yValue];
    };
    
    _miniBarValue = 0.f;
    _originX = self.frame.origin.x;
    _yMarginView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _chartMarginLeft, self.frame.size.height)];
    _yMarginView.backgroundColor = [UIColor whiteColor];
    //[self addSubview:_yMarginView];
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
//    [self addGestureRecognizer:panGesture];
}

- (void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    //make the _yLabelSum value dependant of the distinct values of yValues to avoid duplicates on yAxis
    
    if (_showLabel) {
        [self __addYCoordinateLabelsValues];
    } else {
        [self processYMaxValue];
    }
}

- (void)processYMaxValue {
    NSArray *yAxisValues = _yLabels ? _yLabels : _yValues;
    _yLabelSum = _yLabels ? _yLabels.count - 1 :_yLabelSum;
    if (_yMaxValue) {
        _yValueMax = _yMaxValue;

    } else {
        [self getYValueMax:yAxisValues];
    }
    
    if (_yLabelSum==4&&yAxisValues==_yValues) {
        _yLabelSum = yAxisValues.count;
        (_yLabelSum % 2 == 0) ? _yLabelSum : _yLabelSum++;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    float sectionHeight = (self.frame.size.height - _chartMarginTop - _chartMarginBottom - kXLabelHeight) / _yLabelSum;
    for (int i = 0; i <= _yLabelSum; i++) {
        // draw y axis separator
        CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1].CGColor);
        CGPoint point = CGPointMake(_chartMarginLeft, sectionHeight * i + _chartMarginTop);
        CGContextMoveToPoint(ctx, point.x, point.y);
        CGContextAddLineToPoint(ctx, self.frame.size.width - _chartMarginRight, point.y);
        CGContextStrokePath(ctx);
    }
}

#pragma mark - Private Method
#pragma mark - Add Y Label
- (void)__addYCoordinateLabelsValues{
    
    [self viewCleanupForCollection:_yChartLabels];
    
    [self processYMaxValue];
    
    float sectionHeight = (self.frame.size.height - _chartMarginTop - _chartMarginBottom - kXLabelHeight) / _yLabelSum;
    
    for (int i = 0; i <= _yLabelSum; i++) {
        NSString *labelText;
        if (_yLabels) {
            float yAsixValue = [_yLabels[_yLabels.count - i-1] floatValue];
            labelText= _yLabelFormatter(yAsixValue);
        } else {
            labelText = _yLabelFormatter((float)_yValueMax * ( (_yLabelSum - i) / (float)_yLabelSum ));
        }
        
        PNChartLabel *label = [[PNChartLabel alloc] initWithFrame:CGRectZero];
        label.font = _labelFont;
        label.textColor = _labelTextColor;
        [label setTextAlignment:NSTextAlignmentRight];
        label.text = [NSString stringWithFormat:@"%@%@%@", _yLabelPrefix, labelText, _yLabelSuffix];
        
        [_yMarginView addSubview:label];
        
        label.frame = (CGRect){0, sectionHeight * i + _chartMarginTop - kYLabelHeight/2.0, _yChartLabelWidth, kYLabelHeight};
        
        [_yChartLabels addObject:label];
        
    }
}

-(void)updateChartData:(NSArray *)data{
    self.yValues = data;
    [self updateBar];
}

- (void)getYValueMax:(NSArray *)yLabels
{
    NSArray *labels;
    if (yLabels == _yValues) {
        NSMutableArray *maxs = [NSMutableArray array];
        for (NSArray *values in yLabels) {
            [maxs addObject:[values valueForKeyPath:@"@max.floatValue"]];
        }
        labels = maxs;
    }else{
        labels = yLabels;
    }
    
    //CGFloat max = [[yLabels valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat max = [[labels valueForKeyPath:@"@max.floatValue"] floatValue];
    
    
    //ensure max is even
    _yValueMax = max ;
    
    if (_yValueMax == 0) {
        _yValueMax = _yMinValue;
    }
}

- (void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    
    if (_xChartLabels) {
        [self viewCleanupForCollection:_xChartLabels];
    }else{
        _xChartLabels = [NSMutableArray new];
    }
    
    NSInteger emptyCount = 0;
    for (NSString *value in xLabels) {
        if ([value isEqualToString:@""]) {
            ++emptyCount;
        }
    }
    
    _xLabelWidth = (self.frame.size.width - _chartMarginLeft - _chartMarginRight) / [xLabels count];
    _springXLabelWidth = (self.frame.size.width - _chartMarginLeft - _chartMarginRight) / ([xLabels count]-emptyCount);
    
    if (_showLabel) {
        int labelAddCount = 0;
        for (int index = 0; index < _xLabels.count; index++) {
            labelAddCount += 1;
            
            if (labelAddCount == _xLabelSkip) {
                NSString *labelText = [_xLabels[index] description];
                PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(0, 0, _springXLabelWidth, kXLabelHeight)];
                label.font = _labelFont;
                label.textColor = _labelTextColor;
                [label setTextAlignment:NSTextAlignmentCenter];
                label.text = labelText;
                //[label sizeToFit];
                CGFloat labelXPosition;
                if (_rotateForXAxisText){
                    label.transform = CGAffineTransformMakeRotation(M_PI / 4);
                    labelXPosition = (index *  _xLabelWidth + _chartMarginLeft + _xLabelWidth /1.5);
                }
                else{
                    labelXPosition = (index *  _xLabelWidth + _chartMarginLeft + _xLabelWidth /2.0 );
                }
                label.center = CGPointMake(labelXPosition,
                                           self.frame.size.height - kXLabelHeight - _chartMarginTop + label.frame.size.height /2.0 + _labelMarginTop);
                labelAddCount = 0;
                
                [_xChartLabels addObject:label];
                [self addSubview:label];
            }
        }
    }
}


- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
}

- (void)updateBar
{
    
    //Add bars
    CGFloat chartCavanHeight = self.frame.size.height - _chartMarginTop - _chartMarginBottom - kXLabelHeight;
    NSInteger item = 0;
    NSInteger itemCount = _yValues.count;
    
    for (NSArray *values in _yValues) {
        
        NSInteger sectionCount = values.count;
        NSInteger section = 0;
        NSMutableArray *cluster = [NSMutableArray array];
        for (NSNumber *valueString in values) {
            PNBar *bar;
            
            if (_bars.count == _yValues.count&&(_bars.count>item&&[_bars[item] count]==sectionCount)) {
                bar = [_bars objectAtIndex:item][section];
            }else{
                CGFloat barWidth;
                CGFloat barXPosition;
                
//                CGFloat labelXPosition;
//                if (_rotateForXAxisText){
//                    labelXPosition = (section *  _xLabelWidth + _chartMarginLeft + _xLabelWidth /1.5);
//                }
//                else{
//                    labelXPosition = (section *  _xLabelWidth + _chartMarginLeft + _xLabelWidth /2.0 );
//                }

                if (_barWidth) {
                    barWidth = _barWidth;
                    barXPosition = section *  _xLabelWidth + _chartMarginLeft + _xLabelWidth /2.0 - _barWidth /2.0 +item*barWidth/itemCount;
                }else{
                    barXPosition = section *  _xLabelWidth + _chartMarginLeft + _xLabelWidth * 0.25;
                    if (_showLabel) {
                        barWidth = _xLabelWidth * 0.5;
                        
                    }
                    else {
                        barWidth = _xLabelWidth * 0.6;
                        
                    }
                    barXPosition += item*barWidth/itemCount;
                }
                
                barWidth /= itemCount;
                bar = [[PNBar alloc] initWithFrame:CGRectMake(barXPosition, //Bar X position
                                                              /*self.frame.size.height - chartCavanHeight - kXLabelHeight - _chartMarginBottom +*/ _chartMarginTop, //Bar Y position
                                                              barWidth, // Bar witdh
                                                              self.showLevelLine ? chartCavanHeight/2.0:chartCavanHeight)]; //Bar height
                //float t = self.frame.size.height - chartCavanHeight - kXLabelHeight - _chartMarginBottom + _chartMarginTop;
                //Change Bar Radius
                bar.barRadius = _barRadius;
                
                //Set Bar Animation
                bar.displayAnimated = self.displayAnimated;
                
                //Change Bar Background color
                bar.backgroundColor = _barBackgroundColor;
                //Bar StrokColor First
                if (self.strokeColor) {
                    bar.barColor = self.strokeColor;
                }else{
                    bar.barColor = [self barColorAtIndex:item];
                }
                
                if (self.labelTextColor) {
                    bar.labelTextColor = self.labelTextColor;
                }
                
                // Add gradient
                if (self.isGradientShow) {
                    bar.barColorGradientStart = bar.barColor;
                }
                
                //For Click Index
                bar.tag = item*1000+section;
                
                //[_bars addObject:bar];
                [cluster addObject:bar];
                [self addSubview:bar];
            }
            
            //Height Of Bar
            float value = [valueString floatValue];
            float grade =fabsf((float)value / (float)_yValueMax);
            
            if (isnan(grade)) {
                grade = 0;
            }else if (grade == 0.f){
                grade = _miniBarValue;
            }
            bar.maxDivisor = (float)_yValueMax;
            bar.grade = grade;
            bar.isShowNumber = self.isShowNumbers;
            CGRect originalFrame = bar.frame;
            NSString *currentNumber =  [NSString stringWithFormat:@"%f",value];
            
            if ([[currentNumber substringToIndex:1] isEqualToString:@"-"] && self.showLevelLine) {
                CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI);
                [bar setTransform:transform];
                originalFrame.origin.y = bar.frame.origin.y + bar.frame.size.height;
                bar.frame = originalFrame;
                bar.isNegative = YES;
                
            }
            section += 1;
        }
        [_bars addObject:cluster];
        item += 1;
    }
    
    
    
    //    for (NSNumber *valueString in _yValues) {
    //
    //        PNBar *bar;
    //
    //        if (_bars.count == _yValues.count) {
    //            bar = [_bars objectAtIndex:index];
    //        }else{
    //            CGFloat barWidth;
    //            CGFloat barXPosition;
    //
    //            if (_barWidth) {
    //                barWidth = _barWidth;
    //                barXPosition = index *  _xLabelWidth + _chartMarginLeft + _xLabelWidth /2.0 - _barWidth /2.0;
    //            }else{
    //                barXPosition = index *  _xLabelWidth + _chartMarginLeft + _xLabelWidth * 0.25;
    //                if (_showLabel) {
    //                    barWidth = _xLabelWidth * 0.5;
    //
    //                }
    //                else {
    //                    barWidth = _xLabelWidth * 0.6;
    //
    //                }
    //            }
    //
    //            bar = [[PNBar alloc] initWithFrame:CGRectMake(barXPosition, //Bar X position
    //                                                          self.frame.size.height - chartCavanHeight - kXLabelHeight - _chartMarginBottom + _chartMarginTop , //Bar Y position
    //                                                          barWidth, // Bar witdh
    //                                                          self.showLevelLine ? chartCavanHeight/2.0:chartCavanHeight)]; //Bar height
    //
    //            //Change Bar Radius
    //            bar.barRadius = _barRadius;
    //
    //            //Set Bar Animation
    //            bar.displayAnimated = self.displayAnimated;
    //
    //            //Change Bar Background color
    //            bar.backgroundColor = _barBackgroundColor;
    //            //Bar StrokColor First
    //            if (self.strokeColor) {
    //                bar.barColor = self.strokeColor;
    //            }else{
    //                bar.barColor = [self barColorAtIndex:index];
    //            }
    //
    //            if (self.labelTextColor) {
    //                bar.labelTextColor = self.labelTextColor;
    //            }
    //
    //            // Add gradient
    //            if (self.isGradientShow) {
    //             bar.barColorGradientStart = bar.barColor;
    //            }
    //
    //            //For Click Index
    //            bar.tag = index;
    //
    //            [_bars addObject:bar];
    //            [self addSubview:bar];
    //        }
    //
    //        //Height Of Bar
    //        float value = [valueString floatValue];
    //        float grade =fabsf((float)value / (float)_yValueMax);
    //
    //        if (isnan(grade)) {
    //            grade = 0;
    //        }
    //        bar.maxDivisor = (float)_yValueMax;
    //        bar.grade = grade;
    //        bar.isShowNumber = self.isShowNumbers;
    //        CGRect originalFrame = bar.frame;
    //        NSString *currentNumber =  [NSString stringWithFormat:@"%f",value];
    //
    //        if ([[currentNumber substringToIndex:1] isEqualToString:@"-"] && self.showLevelLine) {
    //        CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI);
    //        [bar setTransform:transform];
    //        originalFrame.origin.y = bar.frame.origin.y + bar.frame.size.height;
    //        bar.frame = originalFrame;
    //        bar.isNegative = YES;
    //
    //      }
    //      index += 1;
    //    }
}

- (void)strokeChart
{
    //Add Labels
    
    [self viewCleanupForCollection:_bars];
    
    [self setNeedsDisplay];
    
    //Update Bar
    
    [self updateBar];
    
    CGRect yMarginViewFrame = _yMarginView.frame;
    yMarginViewFrame.origin.x = -self.frame.origin.x + _originX;
    yMarginViewFrame.size.width = _chartMarginLeft;
    yMarginViewFrame.size.height = self.height;
    _yMarginView.frame = yMarginViewFrame;
    [self addSubview:_yMarginView];
    
    //Add chart border lines
    
    if (_showChartBorder) {
        _chartBottomLine = [CAShapeLayer layer];
        _chartBottomLine.lineCap      = kCALineCapButt;
        _chartBottomLine.fillColor    = [[UIColor whiteColor] CGColor];
        _chartBottomLine.lineWidth    = 1.0;
        _chartBottomLine.strokeEnd    = 0.0;
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        
        [progressline moveToPoint:CGPointMake(_chartMarginLeft, self.frame.size.height - kXLabelHeight - _chartMarginBottom + _chartMarginTop)];
        [progressline addLineToPoint:CGPointMake(self.frame.size.width - _chartMarginRight,  self.frame.size.height - kXLabelHeight - _chartMarginBottom + _chartMarginTop)];
        
        [progressline setLineWidth:1.0];
        [progressline setLineCapStyle:kCGLineCapSquare];
        _chartBottomLine.path = progressline.CGPath;
        _chartBottomLine.strokeColor = [_chartBorderColor CGColor];;
        _chartBottomLine.strokeEnd = 1.0;
        
        [self.layer addSublayer:_chartBottomLine];
        
        //Add left Chart Line
        
        _chartLeftLine = [CAShapeLayer layer];
        _chartLeftLine.lineCap      = kCALineCapButt;
        _chartLeftLine.fillColor    = [[UIColor whiteColor] CGColor];
        _chartLeftLine.lineWidth    = 1.0;
        _chartLeftLine.strokeEnd    = 0.0;
        
        UIBezierPath *progressLeftline = [UIBezierPath bezierPath];
        
        [progressLeftline moveToPoint:CGPointMake(_chartMarginLeft, self.frame.size.height - kXLabelHeight - _chartMarginBottom + _chartMarginTop)];
        [progressLeftline addLineToPoint:CGPointMake(_chartMarginLeft,  _chartMarginTop)];
        
        [progressLeftline setLineWidth:1.0];
        [progressLeftline setLineCapStyle:kCGLineCapSquare];
        _chartLeftLine.path = progressLeftline.CGPath;
        _chartLeftLine.strokeColor = [_chartBorderColor CGColor];
        _chartLeftLine.strokeEnd = 1.0;
        
        [self addBorderAnimationIfNeeded];
        [self.layer addSublayer:_chartLeftLine];
    }
    
    // Add Level Separator Line
    if (_showLevelLine) {
        _chartLevelLine = [CAShapeLayer layer];
        _chartLevelLine.lineCap      = kCALineCapButt;
        _chartLevelLine.fillColor    = [[UIColor whiteColor] CGColor];
        _chartLevelLine.lineWidth    = 1.0;
        _chartLevelLine.strokeEnd    = 0.0;
        
        UIBezierPath *progressline = [UIBezierPath bezierPath];
        
        [progressline moveToPoint:CGPointMake(_chartMarginLeft, (self.frame.size.height - kXLabelHeight )/2.0)];
        [progressline addLineToPoint:CGPointMake(self.frame.size.width - _chartMarginLeft - _chartMarginRight,  (self.frame.size.height - kXLabelHeight )/2.0)];
        
        [progressline setLineWidth:1.0];
        [progressline setLineCapStyle:kCGLineCapSquare];
        _chartLevelLine.path = progressline.CGPath;
        
        _chartLevelLine.strokeColor = PNLightGrey.CGColor;
        
        [self addSeparatorAnimationIfNeeded];
        _chartLevelLine.strokeEnd = 1.0;
        
        [self.layer addSublayer:_chartLevelLine];
    } else {
        if (_chartLevelLine) {
            [_chartLevelLine removeFromSuperlayer];
            _chartLevelLine = nil;
        }
    }
}

- (void)addBorderAnimationIfNeeded
{
    if (self.displayAnimated) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [_chartBottomLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        CABasicAnimation *pathLeftAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathLeftAnimation.duration = 0.5;
        pathLeftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathLeftAnimation.fromValue = @0.0f;
        pathLeftAnimation.toValue = @1.0f;
        [_chartLeftLine addAnimation:pathLeftAnimation forKey:@"strokeEndAnimation"];
    }
}

- (void)addSeparatorAnimationIfNeeded
{
    if (self.displayAnimated) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        [_chartLevelLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
}

- (void)viewCleanupForCollection:(NSMutableArray *)array
{
    if (array.count) {
        for (id obj in array) {
            if ([obj isKindOfClass:[NSArray class]]) {
                [obj makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [obj removeAllObjects];
            }else{
                UIView *view = (UIView*)obj;
                [view removeFromSuperview];
            }
        }
        [array removeAllObjects];
    }
}


#pragma mark - Class extension methods

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    if ([self.strokeColors count] == [self.yValues count]) {
        return self.strokeColors[index];
    }
    else {
        return self.strokeColor;
    }
}

#pragma mark - Touch detection

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _startPoint = [[touches anyObject] locationInView:self.superview];
    _startPX = self.frame.origin.x;
    [self touchPoint:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.superview];
    float dx = point.x - _startPoint.x;
    float dy = point.y - _startPoint.y;
    BOOL vertical = fabs(dy/dx)>1.5;
    if (vertical) {
        [super touchesMoved:touches withEvent:event];
    }else{
        CGPoint offset = CGPointMake(dx, 0);
        
        CGFloat screenWidth = IS_IOS8?SCREEN_WIDTH:SCREEN_HEIGHT;
        
        if (_originX + self.bounds.size.width > screenWidth) {
            
            if (self.frame.origin.x <= _originX) {
                CGRect newFrame = self.frame;
                
                if ((_startPX + offset.x <= _originX)&&(_startPX+newFrame.size.width+offset.x>=screenWidth)) {
                    newFrame.origin.x = _startPX + offset.x;
                }
                else if (_startPX + offset.x > _originX){
                    newFrame.origin.x = _originX;
                }else if (_startPX+newFrame.size.width+offset.x<screenWidth){
                    newFrame.origin.x = screenWidth - newFrame.size.width;
                }
                
                CGRect yMarginViewFrame = _yMarginView.frame;
                yMarginViewFrame.origin.x += (-newFrame.origin.x + self.frame.origin.x);
                _yMarginView.frame = yMarginViewFrame;
                self.frame = newFrame;
            }
        }
    }
}

- (BOOL)touchPoint:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Get the point user touched
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    UIView *subview = [self hitTest:touchPoint withEvent:nil];
    
    if ([subview isKindOfClass:[PNBar class]] && [self.delegate respondsToSelector:@selector(userClickedOnBarAtIndexPath:)]) {
        [self.delegate userClickedOnBarAtIndexPath:[NSIndexPath indexPathForItem:subview.tag%1000 inSection:subview.tag/1000]];
        return YES;
    }
    return NO;
}

//- (void)handlePanGesture:(UIPanGestureRecognizer*)gesture
//{
//    if (gesture.state == UIGestureRecognizerStateChanged ||
//        gesture.state == UIGestureRecognizerStateEnded) {
//        //注意，这里取得的参照坐标系是该对象的上层View的坐标。
//        CGPoint offset = [gesture translationInView:self.superview];
//        
//        if (_originX + self.bounds.size.width > SCREEN_WIDTH) {
//            
//            if (self.frame.origin.x <= _originX) {
//                CGRect newFrame = self.frame;
//                
//                if ((self.frame.origin.x + offset.x <= _originX)&&(newFrame.origin.x+newFrame.size.width+offset.x>=SCREEN_WIDTH)) {
//                    newFrame.origin.x += offset.x;
//                }
//                else if (self.frame.origin.x + offset.x > _originX){
//                    newFrame.origin.x = _originX;
//                }else if (newFrame.origin.x+newFrame.size.width+offset.x<SCREEN_WIDTH){
//                    newFrame.origin.x = SCREEN_WIDTH - newFrame.size.width;
//                }
//                
//                CGRect yMarginViewFrame = _yMarginView.frame;
//                yMarginViewFrame.origin.x += (-newFrame.origin.x + self.frame.origin.x);
//                _yMarginView.frame = yMarginViewFrame;
//                self.frame = newFrame;
//            }
//        }
//        //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
//        [gesture setTranslation:CGPointMake(0, 0) inView:self.superview];
//    }
//}
@end
