//
//  SDSendVerifycodeView.h
//  SD
//
//  Created by LayZhang on 2017/5/9.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDVerifycodeInputView.h"

@interface SDSendVerifycodeAlertView : UIView

+ (instancetype)sharedSendVerifyCodeView;

+ (void)show;
+ (void)dismiss;


@end
