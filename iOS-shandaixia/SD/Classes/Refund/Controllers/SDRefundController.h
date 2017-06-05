//
//  SDRefundController.h
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDBankCard;
@class SDLending;

@interface SDRefundController : YPCustomNavBarController

@property (nonatomic, strong) NSMutableArray *cardArray;

@property (nonatomic, strong) SDBankCard *defaultBankCard;

@property (nonatomic, strong) SDLending *lending;

@end
