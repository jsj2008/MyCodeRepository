//
//  MActivityIndicatorView.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CustomAlertTypeWaiting,
    CustomAlertTypeCustom
}CustomAlertType;

@interface MActivityIndicatorView : UIView

- (void)showCustomWithAlertOnView:(UIView *)view
                        withTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                            width:(CGFloat)width
                           height:(CGFloat)height
                  backgroundImage:(UIImage *)backgroundImage
                  backgroundColor:(UIColor *)backgroundColor
                     cornerRadius:(CGFloat)cornerRadius
                      shadowAlpha:(CGFloat)shadowAlpha
                            alpha:(CGFloat)alpha
                      contentView:(UIView *)contentView
                             type:(CustomAlertType)type;

- (void)showCustomAlertViewOnView:(UIView *)view withTitle:(NSString *)titleString withType:(CustomAlertType)type;
- (void)hideCustomAlert;

@end
