//
//  MarginCallCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/26.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MarginCallCellView.h"
#import "UIColor+CustomColor.h"

@implementation MarginCallCellView

@synthesize keyName = _keyName;
@synthesize value = _value;


+ (MarginCallCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MarginCallCellView" owner:self options:nil];
    return [nib objectAtIndex:0];
}

- (void)layoutSubviews {
    [_keyName sizeToFit];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextStrokeRect(context, CGRectMake(10, 0, rect.size.width - 20, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor marginCallViewTitleColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, rect.size.height - 2.0f, rect.size.width - 20, 0.1f));
}


@end
