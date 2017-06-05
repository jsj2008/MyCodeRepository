//
//  SDLoanProcedureController.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSettingController.h"
@class SDLoan;
@class SDBankCard;
@class SDSpecialDiscount;

@interface SDLoanProcedureController : SDSettingController

@property (nonatomic, strong) NSMutableArray *cardArray;

@property (nonatomic, strong) SDLoan *loan;

@property (nonatomic, strong) SDBankCard *defaultBankCard;

@property (nonatomic, strong) SDSpecialDiscount *specialDiscount;


@end
