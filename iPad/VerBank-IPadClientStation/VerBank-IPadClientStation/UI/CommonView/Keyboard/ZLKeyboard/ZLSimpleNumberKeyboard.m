//
//  ZLSimpleNumberKeyboard.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ZLSimpleNumberKeyboard.h"
#import "ZLKeyboardTool.h"
#import "ZLKeyboardView.h"

@implementation ZLSimpleNumberKeyboard

- (void)initContent {
    [super initContent];
    [self setBackgroundColor:[UIColor lightGrayColor]];
    UIImage *deleteImage = [UIImage imageNamed:@"c_numKeyboardButtonDeleteBig"];
    UIImage *upImage = [UIImage imageNamed:@"c_numKeyboardButtonUp"];
    UIImage *noramalImage = [UIImage imageNamed:@"c_numKeyboardButtonBig.png"];
    UIImage *returnImage = [UIImage imageNamed:@"images/normal/keyboardReturn"];
    
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
