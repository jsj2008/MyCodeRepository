//
//  UnableTextField.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UnableTextField.h"

@implementation UnableTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
//    if (action == @selector(paste:))
//        return NO;
//    if (action == @selector(select:))
//        return NO;
//    if (action == @selector(selectAll:))
//        return NO;
//    return [super canPerformAction:action withSender:sender];
}

@end
