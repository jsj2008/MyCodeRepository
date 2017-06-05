//
//  SDLoanProcedureBankCardCell.h
//  SD
//
//  Created by 余艾星 on 17/3/7.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDBankCard;

@interface SDLoanProcedureBankCardCell : UITableViewCell



@property (nonatomic, weak) UIImageView *bankIconImageView;

@property (nonatomic, strong) SDBankCard *bankCard;

@property (nonatomic, weak) UIButton *chooseButton;

@property (nonatomic, weak) UIImageView *lineImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
