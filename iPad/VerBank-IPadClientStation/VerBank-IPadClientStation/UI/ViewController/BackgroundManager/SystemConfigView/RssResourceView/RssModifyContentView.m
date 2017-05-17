//
//  RssModifyContentView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "RssModifyContentView.h"
#import "JumpDataCenter.h"
#import "LangCaptain.h"
#import "UIColor+CustomColor.h"
#import "ClientSystemConfig.h"
#import "ZLKeyboardView.h"
#import "LayoutCenter.h"

@interface RssModifyContentView() <ZLKeyboardDelegate>

@end

@implementation RssModifyContentView

@synthesize titleLabel;
@synthesize rssLabel;
@synthesize inputTextField;
@synthesize commitButton;
@synthesize cancelButton;

- (void)initContent {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [titleLabel setBackgroundColor:[UIColor blueButtonColor]];
    
    [rssLabel setText:[NSString stringWithFormat:@"%@:", [[LangCaptain getInstance] getLangByCode:@"RssURL"]]];
    
    [commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Comfirm"] forState:UIControlStateNormal];
    [cancelButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Cancel"] forState:UIControlStateNormal];
    
    [commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    ZLKeyboardView *inputView = [[ZLKeyboardView alloc] initWithType:InputViewStyleLoginNumber];
    self.inputTextField.inputView = inputView;
    [TextFieldUtil removeShortCutItem:self.inputTextField];
    [self.inputTextField  setDelegate:(id)inputView];
    [inputView setKeyboardDelegate:self];
}

- (void)resetContentView {
    NSInteger rssIndex = [[JumpDataCenter getInstance] rssIndex];
    if (rssIndex == -1) {
        [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"RssAdd"]];
        [inputTextField setText:@""];
    } else {
        [titleLabel setText:[[LangCaptain getInstance] getLangByCode:@"RssModify"]];
        [inputTextField setText:[[[ClientSystemConfig getInstance] rssResourceArray] objectAtIndex:rssIndex]];
    }
    [inputTextField selectAll:self];
}

#pragma ZLKeyboard delegate
- (Boolean)textFieldShouldChange:(UITextField *)textField insertText:(NSString *)text {
    return true;
}
- (void)textFiledBeginEdit:(UITextField *)textField {}
- (void)textFieldDidEdit:(UITextField *)textField {}
- (void)textFieldEndEdit:(UITextField *)textField {}

#pragma action
- (void)commitAction {
    NSMutableArray *array = [[ClientSystemConfig getInstance] rssResourceArray];
    NSInteger rssIndex = [[JumpDataCenter getInstance] rssIndex];
    if (rssIndex == -1) {
        [array addObject:inputTextField.text];
    } else {
        [array replaceObjectAtIndex:rssIndex withObject:inputTextField.text];
    }
    [[ClientSystemConfig getInstance] saveConfigData];
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showRssResourceView];
}

- (void)cancelAction {
    [[[LayoutCenter getInstance] backgroundLayoutCenter] showRssResourceView];
}

@end
