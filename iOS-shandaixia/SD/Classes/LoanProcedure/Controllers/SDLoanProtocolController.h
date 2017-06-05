//
//  SDLoanProtocolController.h
//  SD
//
//  Created by 余艾星 on 17/3/10.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDWebProveController.h"
@class SDLoan;
@class SDBankCard;


@interface SDLoanProtocolController : SDWebProveController

@property (nonatomic, strong) NSMutableArray *cardArray;

@property (nonatomic, strong) SDLoan *loan;

@property (nonatomic, strong) SDBankCard *defaultBankCard;


@end
