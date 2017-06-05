//
//  SDBankCardDetailCell.h
//  SD
//
//  Created by 余艾星 on 17/3/7.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDBankCard;

@interface SDBankCardDetailCell : UITableViewCell

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, weak) UIImageView *backView;

@property (nonatomic, strong) SDBankCard *bankCard;

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
