//
//  MyCollectionShopVIewController.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MyCollectionShopViewController.h"
#import "MyCollectionRequest.h"
#import "MyCollectionShopCell.h"

@interface MyCollectionShopViewController ()

@property (nonatomic,strong) NSMutableArray *list;

@property (nonatomic,strong) UIView *emptyView;
@property (nonatomic,strong) UIImageView *emptyImage;
@property (nonatomic,strong) UILabel *emptyLabel;

@end

@implementation MyCollectionShopViewController

- (void)viewDidLoad {
    
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT;
    
   [self initData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    if (self.loadingType == kLoadMore) {
        [params setSafeObject:self.wp forKey:@"wp"];
        [MyCollectionRequest getMyCollectionShopsDataWithParams:params success:^(MCShopResultModel *resultModel) {
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
        [MyCollectionRequest getMyCollectionShopsDataWithParams:params success:^(MCShopResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyView];
            if (resultModel) {
                
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                [self showEmptyView:@"还没有收藏任何店铺哦！"];
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (row == 1) {
        MyCollectionShopCell *cell = [MyCollectionShopCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:section];
//       cell.cellData = @"";
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
    
    if (row == 1) {
        height = [MyCollectionShopCell heightForCell:[self.list safeObjectAtIndex:section]];
    }else if (row == 0) {
        height = 10;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCShopModel *model =[self.list safeObjectAtIndex:indexPath.section];
    [[TTNavigationService sharedService] openUrl:model.link];
}


- (UIView *)emptyView
{
    if (!_emptyView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:self.emptyImage];
        [view addSubview:self.emptyLabel];
        _emptyView = view;
    }
    return _emptyView;
}

- (UIImageView *)emptyImage
{
    if (!_emptyImage) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 199, 217)];
        image.centerX = SCREEN_WIDTH / 2;
        image.centerY = (self.view.height - NAVBAR_HEIGHT - TabsViewHeight) /2;
        image.image = [UIImage imageNamed:@"emptyView"];
        _emptyImage = image;
    }
    return _emptyImage;
}

- (UILabel *)emptyLabel
{
    if (!_emptyLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        label.font = FONT(18);
        label.textColor = Color_Gray(140);
        label.textAlignment = NSTextAlignmentCenter;
        label.text= @"";
        label.top = self.emptyImage.bottom + 5;
        _emptyLabel = label;
        
    }
    return _emptyLabel;
}

- (void)showEmptyView:(NSString *)str
{
    [self.view addSubview:self.emptyView];
    self.emptyLabel.text = str;
}

- (void)hideEmptyView
{
    [self.emptyView removeFromSuperview];
}
@end
