//
//  TextFieldController.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/5.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TextFieldController.h"
#import "ZLKeyboardView.h"

static TextFieldController *instance = nil;

@interface TextFieldController() {
    UIView *rootView;
}

@end

@implementation TextFieldController

@synthesize currentTextFiled;

+ (TextFieldController *)getInstance {
    if (instance == nil) {
        instance = [[TextFieldController alloc] init];
    }
    return instance;
}

- (void)keyboardReturen {
    if (currentTextFiled != nil) {
        ZLKeyboardView *view = (ZLKeyboardView *)currentTextFiled.inputView;
        [view keyboardReturn];
    }
}

@end
