//
//  SDAddBankCardView.h
//  SD
//
//  Created by 余艾星 on 17/2/27.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDInputView;
@class SDBankCard;


@interface SDAddBankCardView : UIView


@property (nonatomic, strong) SDBankCard *bankCard;

@property (nonatomic, weak) SDInputView *bankCardView;

//银行卡号
@property (nonatomic, weak) SDInputView *bankView;

//开户地区
@property (nonatomic, weak) SDInputView *districtView;

@property (nonatomic, weak) SDInputView *phoneView;
@property (nonatomic, weak) SDInputView *verifyCodeView;

@end
