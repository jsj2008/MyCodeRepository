//
//  TextFieldUtil.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/17.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TextFieldUtil.h"

@implementation TextFieldUtil

+ (void)removeShortCutItem:(UITextField *)textField {
    if ([textField respondsToSelector:@selector(inputAssistantItem)]) {
        // iOS9.
        UITextInputAssistantItem* item = [textField inputAssistantItem];
        item.leadingBarButtonGroups = @[];
        item.trailingBarButtonGroups = @[];
    }
}

@end
