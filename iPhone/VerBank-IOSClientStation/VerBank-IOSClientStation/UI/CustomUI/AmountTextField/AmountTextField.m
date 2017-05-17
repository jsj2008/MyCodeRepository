//
//  AmountTextField.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/25.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AmountTextField.h"
#import "DecimalUtil.h"

@implementation AmountTextField

- (void)adjustFormat {
    UITextPosition * start = self.selectedTextRange.start;
    NSInteger distanceEnd = [self offsetFromPosition:start
                                          toPosition:self.endOfDocument];
    NSString *stringValue = [self.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    double value = [stringValue doubleValue];
    NSString *inputString = [DecimalUtil formatNumber:value];
    if ([stringValue isEqualToString:@""]) {
        inputString = @"";
    }
    
    [self setText:inputString];
    UITextPosition *position = [self positionFromPosition:self.endOfDocument offset:-distanceEnd];
    //    self.currentTextField.text = [self.currentTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    //            UITextRange *range = currentFeild.selectedTextRange;
    UITextRange *textRange = [self textRangeFromPosition:position toPosition:position];
    [self setSelectedTextRange:textRange];
}

@end
