//
//  SDMyDiscountController.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "YPCustomNavBarController.h"

@interface SDMyDiscountController : YPCustomNavBarController

//1代表有效优惠券 2代表无效优惠券
@property (nonatomic, copy) NSString *discountType;

@property (nonatomic, weak) UIButton *historyDiscountButton;




@end





