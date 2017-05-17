//
//  OrderPositionCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderPositionCellView.h"
#import "ScreenAuotoSizeScale.h"

@implementation OrderPositionCellView

@synthesize ticketLabel = _ticketLabel;
@synthesize timeLabel = _timeLabel;
@synthesize typeLabel = _typeLabel;
@synthesize instrumentLabel = _instrumentLabel;
@synthesize tradeDirLabel = _tradeDirLabel;
@synthesize amountLabel = _amountLabel;

@synthesize limitPriceView = _limitPriceView;

@synthesize limitNameLabel = _limitNameLabel;
@synthesize limitPriceLabel = _limitPriceLabel;
@synthesize ocoLabel = _ocoLabel;
@synthesize stopNameLabel = _stopNameLabel;
@synthesize stopPriceLabel = _stopPriceLabel;
@synthesize stopMoveNameLabel = _stopMoveNameLabel;
@synthesize stopMoveValueLabel = _stopMoveValueLabel;
@synthesize limitDistanceLabel = _limitDistanceLabel;
@synthesize stopDistanceLabel = _stopDistanceLabel;
@synthesize IDTLimitNameLabel = _IDTLimitNameLabel;
@synthesize IDTLimitValueLabel = _IDTLimitValueLabel;
@synthesize IDTStopNameLabel = _IDTStopNameLabel;
@synthesize IDTStopValueLabel = _IDTStopValueLabel;

//@synthesize marketPrice = _marketPrice;

+ (OrderPositionCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderPositionCellView" owner:self options:nil];
    //    [self scal:[nib objectAtIndex:0]];
    //    OrderPositionCellView * view = [nib objectAtIndex:0];
    //    [self scal:view];
    //    [view setNeedsDisplay];
    return [nib objectAtIndex:0];
}

//- (void)scal:(UIView *)view{
//    for (UIView *subView in [view subviews]) {
//        if ([[subView subviews] count] != 0) {
//            [self scal:subView];
//        } else {
//            CGRect rect = [subView frame];
//            rect.origin.x += 20.0f;
//            [subView setFrame:rect];
//        }
//    }
//}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
//    上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, -1, rect.size.width - 20, 1));
    
//    下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, rect.size.height, rect.size.width - 20, 1));
}

@end
