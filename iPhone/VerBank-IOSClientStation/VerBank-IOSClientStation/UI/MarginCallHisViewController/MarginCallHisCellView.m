//
//  MarginCallHisCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/11.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "MarginCallHisCellView.h"

@implementation MarginCallHisCellView

@synthesize account = _account;
@synthesize time = _time;
@synthesize type = _type;
@synthesize amount = _amount;

+ (MarginCallHisCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MarginCallHisCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

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
