//
//  HedgingCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HedgingCellView.h"

@implementation HedgingCellView

@synthesize buttonView = _buttonView;

@synthesize ticketLabel = _ticketLabel;
@synthesize timeLabel = _timeLabel;

@synthesize instrumentLabel = _instrumentLabel;
@synthesize amountLabel = _amountLabel;
@synthesize floatPLLabel = _floatPLLabel;

@synthesize tradeDirLabel = _tradeDirLabel;
@synthesize openPriceLabel = _openPriceLabel;
@synthesize mktPriceLabel = _mktPriceLabel;

+ (HedgingCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HedgingCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, 0, rect.size.width - 20, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, rect.size.height, rect.size.width - 20, 1));
}

@end
