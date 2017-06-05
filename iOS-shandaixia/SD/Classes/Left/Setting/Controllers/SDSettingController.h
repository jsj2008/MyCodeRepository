//
//  SDSettingController.h
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "YPCustomNavBarController.h"

@interface SDSettingController : YPCustomNavBarController


@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic,copy) NSString *plistName;

@property (nonatomic,strong) NSArray *groups;

@end
