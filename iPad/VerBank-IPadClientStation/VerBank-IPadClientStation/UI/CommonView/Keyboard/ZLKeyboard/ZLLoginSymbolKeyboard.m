//
//  ZLLoginSymbolKeyboard.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/30.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ZLLoginSymbolKeyboard.h"
#import "ZLKeyboardTool.h"
#import "ZLKeyboardView.h"

@implementation ZLLoginSymbolKeyboard

- (void)initContent {
    [super initContent];
    [self setBackgroundColor:[UIColor lightGrayColor]];
    UIImage *deleteImage = [UIImage imageNamed:@"c_numKeyboardSmallButtonDelete"];
    UIImage *upImage = [UIImage imageNamed:@"c_numKeyboardButtonUp"];
    UIImage *noramalImage = [UIImage imageNamed:@"c_numKeyboardSmallButton"];
    UIImage *returnImage = [UIImage imageNamed:@"images/normal/keyboardReturn"];
    UIImage *spaceImage = [UIImage imageNamed:@"c_numKeyboardSpaceButton"];
    
    for (UIView *view in [self  subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            NSUInteger tag = button.tag;
            UIImage *buttonImage = nil;
            UIColor *color = nil;
            NSString *title = @"";
            if (tag <= ButtonTypeStyleNormal ||
                tag == ButtonTypeStyleNumber ||
                tag == ButtonTypeStyleSymbol) {
                title = button.titleLabel.text;
                color = [UIColor grayColor];
                buttonImage = noramalImage;
            } else if(tag == ButtonTypeStyleDelete) {
                title = @"";
                color = [UIColor clearColor];
                buttonImage = deleteImage;
            } else if(tag == ButtonTypeStyleUp) {
                title = @"";
                color = [UIColor clearColor];
                buttonImage = upImage;
            } else if (tag == ButtonTypeStyleReturn) {
                title = @"";
                color = [UIColor clearColor];
                buttonImage = returnImage;
            } else if (tag == ButtonTypeStyleSpace) {
                title = @" ";
                color = [UIColor grayColor];
                buttonImage = spaceImage;
            }
            [ZLKeyboardTool setupBasicButtonsWithTitle:title
                                                 image:buttonImage
                                             highImage:nil
                                            titleColor:color
                                                button:button];
        }
    }
}

@end
