//
//  BlackgroundButton.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TextFieldStyle) {
    TextFieldStyleAmount = 0,
    TextFieldStyleDigist = 1,
    TextFieldStyleStopMove= 2,
    TextFieldStyleOther  = 3,
};

@interface BlackgroundTextField : UITextField

@property TextFieldStyle inputStyle;

@end
