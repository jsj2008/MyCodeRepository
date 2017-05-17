//
//  UnderLineLabel.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UnderLineLabel.h"

@implementation UnderLineLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGSize fontSize =[self.text sizeWithFont:self.font
                                    forWidth:self.frame.size.width
                               lineBreakMode:NSLineBreakByTruncatingTail];
    
    CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);  // set as the text's color
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGPoint leftPoint = CGPointMake(0,
                                    fontSize.height - 2.0f);
    CGPoint rightPoint = CGPointMake(fontSize.width,
                                     fontSize.height - 2.0f);
    CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
    CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
    CGContextStrokePath(ctx);
}

@end
