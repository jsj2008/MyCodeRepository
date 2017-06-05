//
//  SDSpecialDiscountController.h
//  SD
//
//  Created by 余艾星 on 17/3/15.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"
@class SDLoan;
@class SDSpecialDiscount;

@protocol SDSpecialDiscountControllerDelegate <NSObject>

- (void)sprcialDiscountDidClicked:(SDSpecialDiscount *)specialDiscount selectedIndex:(NSInteger)selectedIndex;

@end

@interface SDSpecialDiscountController : YPCustomNavBarController

@property (nonatomic, weak) id<SDSpecialDiscountControllerDelegate> delegate;

@property (nonatomic, strong) SDLoan *loan;

//被选中的优惠券
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *discountArray;

@end
