//
//  ZLLoginNumberKeyboard.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/30.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ZLLoginNumberKeyboard.h"
#import "ZLKeyboardTool.h"
#import "ZLKeyboardView.h"

@implementation ZLLoginNumberKeyboard

- (void)initContent {
    [super initContent];
    [self setBackgroundColor:[UIColor lightGrayColor]];
    UIImage *deleteImage = [UIImage imageNamed:@"c_numKeyboardSmallButtonDelete"];
    UIImage *upImage = [UIImage imageNamed:@"c_numKeyboardButtonUp"];
    UIImage *noramalImage = [UIImage imageNamed:@"c_numKeyboardSmallButton"];
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

- (void)needPwd:(Boolean)isNeedPwd {
    NSMutableArray *numberArray = [[NSMutableArray alloc] init];
    
    // xib 中的 按钮顺序 不能改变
    for (UIView *view in [self subviews]) {
        if (![view isKindOfClass:[UIButton class]]) {
            continue;
        }
        UIButton *button = (UIButton *)view;
        if ([self isPureInt:button.titleLabel.text]) {
            [numberArray addObject:button];
        }
    }
    
    if ([numberArray count] != 10) {
        NSLog(@"keyboard number err !!!");
        return;
    }
    
    if (isNeedPwd) {
        [self changeTitleArray:numberArray];
    } else {
        for (int i = 0; i < 10; i++) {
            UIButton *button = [numberArray objectAtIndex:i];
            [button setTitle:[@(i) stringValue] forState:UIControlStateNormal];
        }
    }
}

- (void)changeTitleArray:(NSArray *)array {
    NSMutableArray *numberArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    for (UIButton *button in array) {
        int loc = arc4random_uniform((int)numberArray.count);
        [button setTitle:[numberArray objectAtIndex:loc]forState:UIControlStateNormal];
        [numberArray removeObjectAtIndex:loc];
    }
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
