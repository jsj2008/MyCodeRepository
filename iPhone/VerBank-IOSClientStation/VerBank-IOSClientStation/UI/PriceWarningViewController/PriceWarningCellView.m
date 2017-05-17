//
//  PriceWarningCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PriceWarningCellView.h"

@implementation PriceWarningCellView

@synthesize instrumentLabel = _instrumentLabel;
@synthesize buySellLabel = _buySellLabel;
@synthesize warningPriceLabel = _warningPriceLabel;
@synthesize timeLabel = _timeLabel;

+ (PriceWarningCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PriceWarningCellView"owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));
    
    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
    
}


@end
