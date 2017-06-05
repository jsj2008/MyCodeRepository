//
//  SDActivityCell.h
//  SD
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDMassages;

@interface SDActivityCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SDMassages *massages;

@end
