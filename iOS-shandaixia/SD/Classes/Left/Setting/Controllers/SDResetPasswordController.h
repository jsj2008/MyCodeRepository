//
//  SDResetPasswordController.h
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"
#import "SDAccount.h"

@interface SDResetPasswordController : YPCustomNavBarController

@property (nonatomic, assign) SDMassageType massageType;

@property (nonatomic, copy) NSString *oldPassword;

@end