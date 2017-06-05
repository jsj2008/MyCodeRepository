//
//  SDDiscountCell.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/20.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDDiscount;
@class SDSpecialDiscount;

@interface SDDiscountCell : UITableViewCell

@property (nonatomic, strong) SDDiscount *discount;

@property (nonatomic, strong) SDSpecialDiscount *specialDiscount;
@property (nonatomic, copy) NSString *discountType;

//选中按钮
@property (nonatomic, weak) UIButton *selectedButton;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
