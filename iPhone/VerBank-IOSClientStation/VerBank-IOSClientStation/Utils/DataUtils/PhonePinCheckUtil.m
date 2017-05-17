//
//  PhonePinCheckUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/14.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "PhonePinCheckUtil.h"
#import "StringUtil.h"

#define PhinePinLength 6

@implementation PhonePinCheckUtil

+ (Boolean)isPhonePinLegal:(NSString *)phonePin {
    if ([phonePin length] != PhinePinLength) {
        return false;
    }
    
    if (![StringUtil isPureInt:phonePin]) {
        return false;
    }
    
    if (![self check:phonePin]) {
        return false;
    }
    
    return true;
}

+ (Boolean) check:(NSString *)phonePin {
    
    char char0 = [phonePin characterAtIndex:0];
    char char1 = [phonePin characterAtIndex:1];
    char char2 = [phonePin characterAtIndex:2];
    char char3 = [phonePin characterAtIndex:3];
    char char4 = [phonePin characterAtIndex:4];
    char char5 = [phonePin characterAtIndex:5];
    
    if (![self checkIsLegal:char0 char1:char1 char2:char2]) {
        return false;
    }
    if (![self checkIsLegal:char1 char1:char2 char2:char3]) {
        return false;
    }
    if (![self checkIsLegal:char2 char1:char3 char2:char4]) {
        return false;
    }
    if (![self checkIsLegal:char3 char1:char4 char2:char5]) {
        return false;
    }
    
    return true;
}

+ (Boolean) checkIsLegal:(char) c0 char1:(char)c1 char2:(char)c2 {
    if (c0 == c1 && c1 == c2) {
        return false;
    }
    if ((c1 - c0) == (c2 - c1)) {
        if (abs(c1 - c0) == 1) {
            return false;
        }
    }
    return true;
}


@end
