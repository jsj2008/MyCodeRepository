//
//  DSCustomerListViewController.m
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSCustomerListViewController.h"
#import "CustomerPromoteRequest.h"
#import "DSCustomerCell.h"

@interface DSCustomerListViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSString *keyword;
@end

@implementation DSCustomerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_White;
    [self addNavigationBar];
    [self addSearchBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    self.tableView.top = NAVBAR_HEIGHT + 44;
    self.tableView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT - 44;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.title = @"客户管理";
    [self initData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray array];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.keyword forKey:@"keyword"];
    if (self.loadingType == kLoadMore) {
        [params setSafeObject:self.wp forKey:@"wp"];
        [CustomerPromoteRequest getCustomerListWithParams:params success:^(DSCustomerListResultModel *resultModel) {
            if (resultModel) {
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            [self finishLoadMore];
            [self reloadData];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishLoadMore];
            [self reloadData];
        }];
    }else{
        [CustomerPromoteRequest getCustomerListWithParams:params success:^(DSCustomerListResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyTips];
            if (resultModel) {
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                [self showEmptyTips:@"当前没有相关客户哦" ownerView:self.tableView offsetTop:0];
            }
            [self finishRefresh];
            [self reloadData];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
        }];
    }
}

- (void)addSearchBar
{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 44)];
    [self.searchBar setPlaceholder:@"通过手机号、昵称搜索"];
    [self.searchBar setDelegate:self];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:self.searchBar];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        DSCustomerCell *cell = [DSCustomerCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:row];
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
        height = [DSCustomerCell heightForCell:[self.list safeObjectAtIndex:row]];
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSInteger row = indexPath.row;
    //    NSInteger section = indexPath.section;
    //    if (section == 0) {
    //        DSDistributorModel *model = [self.list safeObjectAtIndex:row];
    //        [[TTNavigationService sharedService] openUrl:model.link];
    //    }
}

#pragma mark - searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
    self.keyword = searchBar.text;
    [self initData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar endEditing:YES];
    self.keyword = nil;
    [self initData];
}
@end
