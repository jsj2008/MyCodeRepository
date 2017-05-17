//
//  OrderHisPopCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderHisPopCellView.h"

@implementation OrderHisPopCellView

@synthesize limitPriceNameLabel = _limitPriceNameLabel;
@synthesize limitPriceValueLabel = _limitPriceValueLabel;
@synthesize ocoLabel = _ocoLabel;
@synthesize stopPriceNameLabel = _stopPriceNameLabel;
@synthesize stopPriceValueLabel = _stopPriceValueLabel;
@synthesize moveStopNameLabel = _moveStopNameLabel;
@synthesize moveStopValueLabel = _moveStopValueLabel;
@synthesize IDTLimitNameLabel = _IDTLimitNameLabel;
@synthesize IDTLimitValueLabel = _IDTLimitValueLabel;
@synthesize IDTStopNameLabel = _IDTStopNameLabel;
@synthesize IDTStopValueLabel = _IDTStopValueLabel;
@synthesize timeNameLabel = _timeNameLabel;
@synthesize timeTypeLabel = _timeTypeLabel;


+ (OrderHisPopCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderHisPopCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1.0f));
    
}

@end
