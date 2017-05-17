//
//  PositionSumCellView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PositionSumCellView.h"

@implementation PositionSumCellView

@synthesize instrumentLabel = _instrumentLabel;
@synthesize sumAmountLabel = _sumAmountLabel;
@synthesize sumFloatPLLabel = _sumFloatPLLabel;
@synthesize tradeDirLabel = _tradeDirLabel;
@synthesize sellLable = _sellLable;
@synthesize buyLabel = _buyLabel;
@synthesize sellAmountLabel = _sellAmountLabel;
@synthesize buyAmountLabel = _buyAmountLabel;
@synthesize sellAvgLabel = _sellAvgLabel;
@synthesize buyAvgLabel = _buyAvgLabel;
@synthesize sellFloatPLLabel = _sellFloatPLLabel;
@synthesize buyFloatPLLabel = _buyFloatPLLabel;

+ (PositionSumCellView *)newInstance{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PositionSumCellView"owner:self options:nil];
//    PositionSumCellView *view = (PositionSumCellView *)[nib objectAtIndex:0];
//    [view addListener];
    return [nib objectAtIndex:0];
}

//- (void)addListener {
//    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)];
//    [self.instrumentLabel addGestureRecognizer:tapGesture];
//}




- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));

}

@end
