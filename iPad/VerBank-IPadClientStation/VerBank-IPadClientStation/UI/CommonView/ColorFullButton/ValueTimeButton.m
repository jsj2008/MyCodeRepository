//
//  ValueTimeButton.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/11.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "ValueTimeButton.h"
#import "MTP4CommDataInterface.h"
#import "LangCaptain.h"
#import "ValueTimeUtil.h"

@interface ValueTimeButton() {
    NSUInteger  _dateType;
    NSDate      *_valueDate;
    NSString    *_valueTime;
}

@end

@implementation ValueTimeButton

//@synthesize dateType;
//@synthesize dateValueTime;

@synthesize valueTimeButtonType;
@synthesize timeShowButton;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setDefault];
    }
    return self;
}

- (void)setDefault {
    CGFloat radio = self.frame.size.height / 2 - 4.0f;
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.cornerRadius = radio;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setDefault];
}

- (void)setDateType:(NSUInteger)type {
     [self.timeShowButton setHidden:true];
    _dateType = type;
    if (type != ORDER_EXPIRE_TYPE_USER_DEFINED) {
        _valueTime = nil;
    }
    NSString *typeString = [[LangCaptain getInstance] getLangByCode:[NSString stringWithFormat:@"ORDER_EXPIRE_TYPE_%lu", (unsigned long)type]];
    [self setTitle:[NSString stringWithFormat:@"  %@", typeString]
          forState:UIControlStateNormal];
    
    NSTimeInterval intervalTime = 0;
    
    switch (type) {
        case ORDER_EXPIRE_TYPE_H1:
            intervalTime = 1 * 60 * 60;
            break;
        case ORDER_EXPIRE_TYPE_H2:
            intervalTime = 2 * 60 * 60;
            break;
        case ORDER_EXPIRE_TYPE_H4:
            intervalTime = 4 * 60 * 60;
            break;
        case ORDER_EXPIRE_TYPE_H8:
            intervalTime = 8 * 60 * 60;
            break;
        case ORDER_EXPIRE_TYPE_H12:
            intervalTime = 12 * 60 * 60;
            break;
        case ORDER_EXPIRE_TYPE_H16:
            intervalTime = 16 * 60 * 60;
            break;
        default:
            break;
    }
    if (intervalTime != 0) {
        NSDate *now = [[NSDate alloc]initWithTimeIntervalSinceNow:intervalTime];
        _valueDate = now;
        _dateType = ORDER_EXPIRE_TYPE_USER_DEFINED;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        _valueTime = [NSString stringWithFormat:@"%@:00", [dateFormat stringFromDate:_valueDate]];
        //        _valueTime = valueString;
        [self setTitle:[NSString stringWithFormat:@"  %@", [dateFormat stringFromDate:_valueDate]]
              forState:UIControlStateNormal];
    } else {
        if (_dateType == ORDER_EXPIRE_TYPE_DAY) {
            
            NSDate *time = [ValueTimeUtil parseExpireTypeToDate:ORDER_EXPIRE_TYPE_DAY];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *timeString = [NSString stringWithFormat:@"  %@", [dateFormat stringFromDate:time]];
            
            
            [self.timeShowButton setTitle:timeString
                  forState:UIControlStateNormal];
            [self.timeShowButton setHidden:false];
        }
        if (_dateType == ORDER_EXPIRE_TYPE_WEEK) {
            NSDate *time = [ValueTimeUtil parseExpireTypeToDate:ORDER_EXPIRE_TYPE_WEEK];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *timeString = [NSString stringWithFormat:@"  %@", [dateFormat stringFromDate:time]];

            [self.timeShowButton setTitle:timeString
                                 forState:UIControlStateNormal];
            [self.timeShowButton setHidden:false];
        }
    }
    
}

- (void)setDateValueTime:(NSDate *)valueDate {
    if (_dateType == ORDER_EXPIRE_TYPE_USER_DEFINED) {
        _valueDate = valueDate;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        _valueTime = [NSString stringWithFormat:@"%@:00", [dateFormat stringFromDate:valueDate]];
        //        _valueTime = valueString;
        [self setTitle:[NSString stringWithFormat:@"  %@", [dateFormat stringFromDate:valueDate]]
              forState:UIControlStateNormal];
    }
}

- (NSString *)getDateValueTime {
    return _valueTime;
}

- (NSDate *)getDateValueDate {
    return _valueDate;
}

- (NSUInteger)getDateType {
    if (_dateType == ORDER_EXPIRE_TYPE_GTC) {
        return _dateType;
    }
    
    if (_dateType == ORDER_EXPIRE_TYPE_DAY) {
        return _dateType;
    }
    
    if (_dateType == ORDER_EXPIRE_TYPE_WEEK) {
        return _dateType;
    }
    return ORDER_EXPIRE_TYPE_USER_DEFINED;
}

@end
