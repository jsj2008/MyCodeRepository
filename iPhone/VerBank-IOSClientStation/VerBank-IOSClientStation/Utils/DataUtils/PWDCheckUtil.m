//
//  PWDCheckUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PWDCheckUtil.h"

const int MINLENGTH = 6;
const int MAXLENGTH = 12;

@implementation PWDCheckUtil

+ (Boolean)isPwdLegal:(NSString *)pwd accountID:(NSString *)accountID {
    if ([pwd isEqualToString:accountID]) {
        return false;
    }
    
    if (![self lengthCheck:pwd]) {
        return false;
    }
    
    if (![self contentCheck:pwd]) {
        return false;
    }
    
    if (![self is3CharsOK:pwd]) {
        return false;
    }
    return true;
}

+ (Boolean)lengthCheck:(NSString *)pwd {
    return [pwd length] >= MINLENGTH && [pwd length] <= MAXLENGTH;
}

+ (Boolean)contentCheck:(NSString *)pwd {
    Boolean hasNumber = false;
    Boolean hasUpperCase = false;
    Boolean hasLowerCase = false;
    Boolean hasMarks = false;
    
    for (int i = 0; i<[pwd length]; i++) {
        char commitChar = [pwd characterAtIndex:i];
        if([self isUppercase:commitChar]){
            hasUpperCase = true;
        }else if([self isLowercase:commitChar]){
            hasLowerCase = true;
        }else if([self isNumber:commitChar]){
            hasNumber = true;
        }else{
            hasMarks = true;
        }
    }
    if (hasNumber && hasLowerCase && (hasUpperCase || hasMarks)) {
        return true;
    } else {
        return false;
    }
}

+ (Boolean)is3CharsOK:(NSString *)pwd {
    int length = (int)[pwd length];
    unsigned char sData[length];
    for (int i = 0; i < length; i++) {
        sData[i] = [pwd characterAtIndex:i];
    }
    
    for (int i = 0; i < length - 2; i ++) {
        char c1 = sData[i];
        char c2 = sData[i + 1];
        char c3 = sData[i + 2];
        if (c1 == c2 && c2 == c3) {
            return false;
        }
        
        int g1 = c2 - c1;
        int g2 = c3 - c2;
        if (g1 != g2) {
            continue;
        }
        
        if (abs(g1) != 1) {
            continue;
        }
        
        if ([self isUppercase:c1] && [self isUppercase:c3]) {
            return false;
        }
        
        if ([self isLowercase:c1] && [self isLowercase:c3]) {
            return false;
        }
        
        if ([self isNumber:c1] && [self isNumber:c3]) {
            return false;
        }
    }
    return true;
}

+ (Boolean)isNumber:(char)checkChar {
    return checkChar > 47 && checkChar < 58;
}

+ (Boolean)isUppercase:(char)checkChar {
    return checkChar > 64 && checkChar < 91;
}

+ (Boolean)isLowercase:(char)checkChar {
    return checkChar > 96 && checkChar < 123;
}

@end
