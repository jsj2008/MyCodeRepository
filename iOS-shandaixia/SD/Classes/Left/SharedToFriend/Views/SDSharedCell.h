//
//  SDSharedCell.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/22.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDShared;

@interface SDSharedCell : UITableViewCell

@property (nonatomic, strong) SDShared *shared;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
