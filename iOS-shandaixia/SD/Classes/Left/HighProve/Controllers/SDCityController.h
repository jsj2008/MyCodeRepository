//
//  SDCityController.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "YPCustomNavBarController.h"

@interface SDCityController : YPCustomNavBarController

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *city;

@property (nonatomic, copy) NSString *channelType;

- (void)addLoanTableView;

@end
