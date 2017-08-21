//
//  DSAccountListViewController.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

extern NSString *const DistributorDidSelectWithdrawAccount;

@interface DSAccountListViewController : BaseTableViewController

@property (nonatomic, strong) NSArray *accounts;

@end
