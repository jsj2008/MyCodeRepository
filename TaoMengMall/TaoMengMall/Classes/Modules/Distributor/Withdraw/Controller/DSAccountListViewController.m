//
//  DSAccountListViewController.m
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSAccountListViewController.h"
#import "DSAccountEditViewController.h"
#import "DSWithdrawAccountModel.h"
#import "DSAccountListCell.h"

NSString *const DistributorDidSelectWithdrawAccount = @"DistributorDidSelectWithdrawAccount";


@interface DSAccountListViewController ()

@end

@implementation DSAccountListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = NO;
    
    self.title = @"请选择提现账户";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return self.accounts.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 1) {
        DSAccountListCell *cell = [DSAccountListCell dequeueReusableCellForTableView:tableView];
        DSWithdrawAccountModel *model = [self.accounts safeObjectAtIndex:row];
        cell.cellData = model;
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        [cell reloadData];
        return cell;
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 1) {
        DSWithdrawAccountModel *model = [self.accounts safeObjectAtIndex:row];
        DSAccountEditViewController *vc = [[DSAccountEditViewController alloc]init];
        vc.account = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        height = 14;
    }else if (section == 1) {
        height = 48;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 1) {
        DSWithdrawAccountModel *model = [self.accounts safeObjectAtIndex:row];
        if (IsEmptyString(model.account)) {
            DSAccountEditViewController *vc = [[DSAccountEditViewController alloc]init];
            vc.account = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DistributorDidSelectWithdrawAccount" object:model];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self clickback];
            });
        }
    }
}
@end
