//
//  ConcreteNews.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/20.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ConcreteNews.h"
#import "LangCaptain.h"

#import "JEDIDateTime.h"

@implementation ConcreteNews

@synthesize backButton;
@synthesize titleLabel;
@synthesize timeLabel;
@synthesize contentTextView;

- (void)initContent {
    [self.backButton setTitle:[[LangCaptain getInstance] getLangByCode:@"Back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    contentTextView.bounces = NO;
    [contentTextView setDataDetectorTypes:UIDataDetectorTypeLink];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

- (void)updateWithFeedItem:(IDNFeedItem *)item {
    [titleLabel setText:[item title]];
    [titleLabel setNumberOfLines:0];
    CGSize constraint = CGSizeMake(self.frame.size.width - 20, 20000.0f);
    CGSize size = [[item title] sizeWithFont:[UIFont systemFontOfSize:20.0f]
                           constrainedToSize:constraint
                               lineBreakMode:NSLineBreakByWordWrapping];
    [titleLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
    [timeLabel setText:[JEDIDateTime stringUIFromDate:[item date]]];
    
    NSString *textContent = [NSString stringWithFormat:@"%@\n\n\n\n%@", [item summary], [item link]];
    [contentTextView setText:textContent];
}

- (void)backAction {
    [self removeFromSuperview];
}

@end
