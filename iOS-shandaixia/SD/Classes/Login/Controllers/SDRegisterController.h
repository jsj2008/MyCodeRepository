//
//  SDRegisterController.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/15.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDLoginButton;

@interface SDRegisterController : YPCustomNavBarController

@property (nonatomic, weak) SDLoginButton *registButton;

@property (nonatomic, copy) NSString *registTitle;

@end
