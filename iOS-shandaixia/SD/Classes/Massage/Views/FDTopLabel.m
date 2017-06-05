//
//  FDTopLabel.m
//  FuDai
//
//  Created by Apple on 16/8/24.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import "FDTopLabel.h"

@implementation FDTopLabel

//- (id)initWithFrame:(CGRect)frame {
//    return [super initWithFrame:frame];
//}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    textRect.origin.y = bounds.origin.y;
    return textRect;
}
-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


+ (FDTopLabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(NSInteger)font textAliment:(NSTextAlignment)textAliment{
    
    FDTopLabel *label = [[FDTopLabel alloc] init];
    
    label.text = text;
    
    label.textColor = color;
    
    label.font = [UIFont systemFontOfSize:font];
    
    if (textAliment) {
        
        label.textAlignment = textAliment;
    }
    
    return label;
}

@end
