//
//  OrderHisCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/13.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OrderHisCellView.h"

@implementation OrderHisCellView

@synthesize ticketLabel = _ticketLabel;
@synthesize orderTimeLabel = _orderTimeLabel;
@synthesize closeTypeLabel = _closeTypeLabel;
@synthesize closePriceLabel = _closePriceLabel;
@synthesize designTicketLabel = _designTicketLabel;
@synthesize instrumentLabel = _instrumentLabel;
@synthesize tradeDirLabel = _tradeDirLabel;
@synthesize tradeAmountLabel = _tradeAmountLabel;

+ (OrderHisCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderHisCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1.0f));

    //下分割线
  //  CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
  //  CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1.0f, rect.size.width, 1.0f));
    
}

@end
