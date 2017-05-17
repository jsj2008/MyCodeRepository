//
//  ConcreteEconomicView.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/12.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ConcreteEconomicView.h"
#import "LangCaptain.h"

@implementation ConcreteEconomicView

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

- (void)updateWithEconomicData:(EconomicData *)economicData {
    [titleLabel setText:[economicData getEconomicData]];
    [titleLabel setNumberOfLines:0];
    CGSize constraint = CGSizeMake(self.frame.size.width - 20, 20000.0f);
    CGSize size = [[economicData getEconomicData] sizeWithFont:[UIFont systemFontOfSize:20.0f]
                           constrainedToSize:constraint
                               lineBreakMode:NSLineBreakByWordWrapping];
    [titleLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
//    [timeLabel setText:[JEDIDateTime stringUIFromDate:[economicData getTime]]];
    
//    NSString *textContent = [NSString stringWithFormat:@"%@\n\n\n\n%@", [economicData summary], [item link]];
//    [contentTextView setText:textContent];
}

- (void)backAction {
    [self removeFromSuperview];
}


@end
