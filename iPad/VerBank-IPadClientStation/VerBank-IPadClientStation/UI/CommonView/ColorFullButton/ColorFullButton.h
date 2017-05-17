//
//  ColorFullButton.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonStyle) {
    ButtonRed       = 0,
    ButtonGray      = 1,
    ButtonBlue      = 2,
    ButtonCealer    = 3
};

@interface ColorFullButton : UIButton

@property CGFloat corner;
@property ButtonStyle style;

@end
