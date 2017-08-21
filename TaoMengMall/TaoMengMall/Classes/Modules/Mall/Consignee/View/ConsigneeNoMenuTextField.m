//
//  NoMenuTextField.m
//  YouCai
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "ConsigneeNoMenuTextField.h"

@implementation ConsigneeNoMenuTextField


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    
    return NO;
}

@end
