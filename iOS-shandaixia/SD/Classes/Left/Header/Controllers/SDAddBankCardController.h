//
//  SDAddBankCardController.h
//  SD
//
//  Created by 余艾星 on 17/2/27.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDBankCard;
@class SDUserCenter;

@interface SDAddBankCardController : YPCustomNavBarController

@property (nonatomic, strong) SDBankCard *bankCard;
@property (nonatomic, strong) SDUserCenter *userCenter;

@end
