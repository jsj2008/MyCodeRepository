//
//  TiArgumentView.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiArgumentView.h"
#import "IosLayoutDefine.h"
#import "LangCaptain.h"



@implementation TiArgumentView

@synthesize backButton = _backButton;
@synthesize commitButton = _commitButton;
@synthesize resetButton = _resetButton;

+ (TiArgumentView *)newInstance {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TiArgumentView" owner:self options:nil];
    TiArgumentView *view = (TiArgumentView *)[nib objectAtIndex:0];
    [view initContentView];
    return view;
}

- (void)initContentView {
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [_backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"]
                 forState:UIControlStateNormal];
    [_commitButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Commit"]
                   forState:UIControlStateNormal];
    [_resetButton setTitle:[[LangCaptain getInstance] getLangByCode:@"ResetArgument"]
                  forState:UIControlStateNormal];
    
    [_backButton setTintColor:[UIColor whiteColor]];
    [_commitButton setTintColor:[UIColor whiteColor]];
    [_resetButton setTintColor:[UIColor whiteColor]];
    
    [self setBackgroundColor:[UIColor blackColor ]];
}



@end
