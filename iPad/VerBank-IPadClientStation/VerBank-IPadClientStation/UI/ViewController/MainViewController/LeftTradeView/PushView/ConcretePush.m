//
//  ConcreteNews.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/20.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ConcretePush.h"
#import "LangCaptain.h"

@implementation ConcretePush

@synthesize backButton;
@synthesize titleLabel;
@synthesize timeLabel;
@synthesize contentTextView;

- (void)initContent {
    [self.backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    contentTextView.bounces = NO;
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateWithPush:(PushFromSystem *)push {
    [titleLabel setText:[push getTitle]];
    [titleLabel setNumberOfLines:0];
    CGSize constraint = CGSizeMake(self.frame.size.width - 20, 20000.0f);
    CGSize size = [[push getTitle] sizeWithFont:[UIFont systemFontOfSize:20.0f]
                                 constrainedToSize:constraint
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    [titleLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    
    [timeLabel setText:[JEDIDateTime stringUIFromDate:[push getTime]]];
    [contentTextView setText:[push getContext]];
}

- (void)backAction {
    [self removeFromSuperview];
}

@end
