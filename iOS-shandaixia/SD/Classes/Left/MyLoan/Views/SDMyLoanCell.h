//
//  SDMyLoanCell.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/20.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDMyLoan;

@interface SDMyLoanCell : UITableViewCell

@property (nonatomic, strong) SDMyLoan *myLoan;

/** 底部虚线 */
@property (nonatomic, weak) UIImageView *lineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
