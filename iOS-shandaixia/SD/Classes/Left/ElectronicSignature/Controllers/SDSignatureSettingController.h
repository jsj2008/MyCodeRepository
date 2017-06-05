//
//  SDSignatureSettingController.h
//  SD
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "YPCustomNavBarController.h"

@interface SDSignatureSettingController : YPCustomNavBarController

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, copy)NSString *realName;

@end
