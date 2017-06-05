//
//  SDBankCardCell.h
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDBankCard;

@interface SDBankCardCell : UITableViewCell

@property (nonatomic, weak) UIImageView *backView;

@property (nonatomic, strong) SDBankCard *bankCard;

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
