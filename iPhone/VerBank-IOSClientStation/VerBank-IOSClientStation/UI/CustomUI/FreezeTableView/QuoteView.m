//
//  QuoteView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/21.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuoteView.h"
#import "UIColor+CustomColor.h"
#import "VerLabel.h"
#import "ScreenAuotoSizeScale.h"

#define Eadge 2.0f

@interface QuoteView(){
    VerLabel *_leftLabel;
    VerLabel *_middleLabel;
    VerLabel *_rightLabel;
}

@end

@implementation QuoteView

@synthesize instrument;
@synthesize isBuySell;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //        CGRect leftRect = CGRectMake(0, 0, frame.size.width / 2, frame.size.height);
        //        CGRect middleRect = CGRectMake(frame.size.width / 2, 0, frame.size.width / 3, frame.size.height);
        //        CGRect rightRect = CGRectMake(frame.size.width / 6 * 5, 0, frame.size.width / 6, frame.size.height);
        
        _leftLabel = [[VerLabel alloc] initWithFrame:CGRectZero];
        _middleLabel = [[VerLabel alloc] initWithFrame:CGRectZero];
        _rightLabel = [[VerLabel alloc] initWithFrame:CGRectZero];
        
        _leftLabel.textAlignment = NSTextAlignmentRight;
        _leftLabel.verticalAlignment = VerticalAlignmentBottom;
        [_leftLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:20.0f]]];
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.verticalAlignment = VerticalAlignmentBottom;
        [_middleLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:28.0f]]];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.verticalAlignment = VerticalAlignmentTop;
        [_rightLabel setFont:[UIFont systemFontOfSize:[ScreenAuotoSizeScale CGAutoMakeFloat:22.0f]]];
        
        [_leftLabel setText:@"00000"];
        [_middleLabel setText:@"0.0"];
        [_rightLabel setText:@"0000"];
        [_leftLabel sizeToFit];
        [_middleLabel sizeToFit];
        [_rightLabel sizeToFit];
        
        CGRect leftFitRect = _leftLabel.frame;
        CGRect leftRect = CGRectMake(frame.size.width / 2 - leftFitRect.size.width,
                                     frame.size.height - leftFitRect.size.height - Eadge,
                                     leftFitRect.size.width,
                                     leftFitRect.size.height);
        
        CGRect middleFitRect = _middleLabel.frame;
        CGRect middleRect = CGRectMake(frame.size.width / 2,
                                       frame.size.height - middleFitRect.size.height / 18 * 17 - Eadge,
                                       middleFitRect.size.width,
                                       middleFitRect.size.height);
        
        CGRect rightFitRect = _rightLabel.frame;
        CGRect rightRect = CGRectMake(frame.size.width / 2 + middleFitRect.size.width,
                                      frame.size.height - middleFitRect.size.height + rightFitRect.size.height / 20,
                                      rightFitRect.size.width,
                                      rightFitRect.size.height);
        
        [_leftLabel setFrame:leftRect];
        [_middleLabel setFrame:middleRect];
        [_rightLabel setFrame:rightRect];
        
        [_leftLabel setBackgroundColor:[UIColor clearColor]];
        [_middleLabel setBackgroundColor:[UIColor clearColor]];
        [_rightLabel setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:_leftLabel];
        [self addSubview:_middleLabel];
        [self addSubview:_rightLabel];
        
        instrument = @"";
    }
    return self;
}

- (void)setPrice:(NSString *)price extraDigit:(int)extraDigit{
    NSArray *array = [self numberTranslation:price midLen:2 digit:extraDigit];
    [_leftLabel setText:[array objectAtIndex:0]];
    [_middleLabel setText:[array objectAtIndex:1]];
    [_rightLabel setText:[array objectAtIndex:2]];
}

//- (NSString *)numberTranslation:(NSString *)value withIndex:(int)index withMidLen:(int)len withDigit:(int)digit{
//    int mainlength = [value length];
//    if (mainlength == 0) {
//        return nil;
//    }
//    int length = mainlength;
//    int flag1 = 0,flag2 = 0;
//
//    if (len + digit > mainlength - 1){
//        NSLog(@"** err range is longer than maxlength..");
//        return nil;
//    }
//
//
//    if (digit == 0){
//        flag1 = length;
//    } else {
//        while (1){
//            if ([[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@","] || [[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@"."]){
//                length --;
//            } else {
//                length --;
//                digit --;
//                if (digit <= 0) {
//                    if ([[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@","] || [[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@"."]){
//                        length --;
//                    }
//                    flag1 = length;
//                    break;
//                }
//            }
//        }
//    }
//
//
//    while (true) {
//        if ([[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@","] || [[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@"."]){
//            length --;
//        } else{
//            length --;
//            len --;
//            if (len <= 0){
//                flag2 = length;
//
//                break;
//            }
//        }
//    }
//    NSString *str1 = [value substringWithRange:NSMakeRange(0, flag2)];
//    NSString *str2 = [value substringWithRange:NSMakeRange(flag2, flag1 - flag2)];
//    NSString *str3 = [value substringWithRange:NSMakeRange(flag1, mainlength - flag1)];
//
//    NSArray *array = [NSArray arrayWithObjects:str1, str2, str3, nil];
//
//        NSLog(@"%@", value);
//        NSLog(@"str1 is == %@, str2 is == %@, str3 is == %@", str1, str2, str3);
//
//    return [array objectAtIndex:index];
//
//}

- (NSArray *)numberTranslation:(NSString *)value midLen:(int)len digit:(int)digit{
    int mainlength = (int)[value length];
    if (mainlength == 0) {
        return nil;
    }
    int length = mainlength;
    int flag1 = 0,flag2 = 0;
    
    if (len + digit > mainlength - 1){
        NSLog(@"** err range is longer than maxlength..");
        return nil;
    }
    
    
    if (digit == 0){
        flag1 = length;
    } else {
        while (1){
            if ([[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@","] || [[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@"."]){
                length --;
            } else {
                length --;
                digit --;
                if (digit <= 0) {
                    if ([[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@","] || [[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@"."]){
                        length --;
                    }
                    flag1 = length;
                    break;
                }
            }
        }
    }
    
    
    while (true) {
        if ([[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@","] || [[self getSubstring:value withIndex:length - 1 andRange:1] isEqualToString:@"."]){
            length --;
        } else{
            length --;
            len --;
            if (len <= 0){
                flag2 = length;
                
                break;
            }
        }
    }
    NSString *str1 = [value substringWithRange:NSMakeRange(0, flag2)];
    NSString *str2 = [value substringWithRange:NSMakeRange(flag2, flag1 - flag2)];
    NSString *str3 = [value substringWithRange:NSMakeRange(flag1, mainlength - flag1)];
    
    //    NSArray *array =
    //    NSLog(@"%@", value);
    //    NSLog(@"str1 is == %@, str2 is == %@, str3 is == %@", str1, str2, str3);
    
    return [NSArray arrayWithObjects:str1, str2, str3, nil];
    
}

- (NSString *)getSubstring:(NSString *)mainString withIndex:(int)index andRange:(int)range{
    @try {
        NSString *subString = [mainString substringWithRange:NSMakeRange(index, range)];
        if ([subString isEqualToString:@""]) {
        }
        return subString;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (void)setColor:(UIColor *)color{
    [_leftLabel setTextColor:color];
    [_middleLabel setTextColor:color];
    [_rightLabel setTextColor:color];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)){
        if (_delegate && [_delegate respondsToSelector:@selector(touchedTradeEvent:buySell:)]) {
            [_delegate touchedTradeEvent:instrument buySell:isBuySell];
        }
    }
}

- (void)dealloc {
    _leftLabel = nil;
    _middleLabel = nil;
    _rightLabel = nil;
}

@end
