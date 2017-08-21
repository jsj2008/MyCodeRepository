//
//  MBOverseasViewViewController.m
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/27.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MBOverseasViewViewController.h"
#import "MBOverseaCell.h"
#import "MallBrandRequest.h"
#import "MBOverseaModel.h"

@interface MBOverseasViewViewController ()

@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation MBOverseasViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    
    self.title = @"海外品牌";
    [self initData];
    
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
        
        [MallBrandRequest getOversseaDataWithParams:params success:^(MBOversseaResulModel *resultModel) {
            
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
    }else {
        [MallBrandRequest getOversseaDataWithParams:params success:^(MBOversseaResulModel *resultModel) {
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
                [self showEmptyTips:@"当前没有海外品牌"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        MBOverseaCell *cell = [MBOverseaCell dequeueReusableCellForTableView:tableView];
        MBOverseaModel *model = [self.list safeObjectAtIndex:row];
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
        MBOverseaModel *model = [self.list safeObjectAtIndex:row];
        height = [MBOverseaCell heightForCell:model];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MBOverseaModel *model = [self.list safeObjectAtIndex:indexPath.row];
//    [TTNavigationService sharedService]

}



@end
