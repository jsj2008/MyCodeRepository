//
//  PMPointDetailViewController.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "PMPointDetailViewController.h"
#import "PMPDPointBalanceCell.h"
#import "PMPointDetailCell.h"
#import "PointMallRequest.h"

@interface PMPointDetailViewController ()

@property (nonatomic,strong) NSMutableArray<PointDetailUsesListModel> *list;
@property (nonatomic,strong) PointDetailResultModel *resultModel;

@end

@implementation PMPointDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    
    self.title = @"淘米";
    [self initData];
}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray<PointDetailUsesListModel> array];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setSafeObject:self.wp forKey:@"wp"];
    
    [PointMallRequest getPointDetailWithParams:params success:^(PointDetailResultModel *resultModel) {
        
        self.resultModel = resultModel;
        [self.list addObjectsFromSafeArray:resultModel.uses.list];
        self.wp = resultModel.uses.wp;
        
        if ( resultModel.uses.isEnd ) {
            self.tableView.showsInfiniteScrolling = NO;
        } else {
            self.tableView.showsInfiniteScrolling = YES;
        }
        
        [self finishRefresh];
        [self reloadData];
        
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
    

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else {
        return self.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        PMPDPointBalanceCell *cell = [PMPDPointBalanceCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.resultModel.balance;
        [cell reloadData];
        return cell;
    }else if(section == 1) {
        PointDetailUsesListModel *model = [self.list objectAtSafeIndex:row];
        PMPointDetailCell *cell = [PMPointDetailCell dequeueReusableCellForTableView:tableView];
        cell.cellData = model;
        [cell reloadData];
        return cell;
    }
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        height = [PMPDPointBalanceCell heightForCell:@""];
    }else if(section == 1) {
        height = [PMPointDetailCell heightForCell:@""];
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    
    if (section == 0) {
        height = 0;
    }else {
        height = 10;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
