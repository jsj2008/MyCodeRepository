//
//  SDLoanSSQSignViewController.h
//  SD
//
//  Created by LayZhang on 2017/5/11.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "YPCustomNavBarController.h"
#import "SDLoan.h"

@interface SDLoanSSQSignViewController : YPCustomNavBarController

@property (nonatomic, strong) SDLoan *loan;
@property (nonatomic, strong) NSString *signid;

- (void)loadSignPageSignimagePc;

@end
