//
//  ODReturnPointViewController.m
//  TaoMengMall
//
//  Created by 任梦晗 on 17/5/12.
//  Copyright © 2017年 任梦晗. All rights reserved.
//

#import "ODReturnPointViewController.h"
#import "OrderRequest.h"
#import "ODReturenPointHeaderCell.h"
#import "ODReturnPointListCell.h"

@interface ODReturnPointViewController ()

@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) ODReturenPointResultModel *resultModel;

@end

@implementation ODReturnPointViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
   
    
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    
    self.title = @"已返淘米";
    [self initData];
    
}


- (void)initData
{
    self.loadingType = kInit;
    self.listArray = [NSMutableArray array];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.planId forKey:@"planId"];
    if (kLoadMore == self.loadingType) {
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [OrderRequest getReturenPointDataWithParams:params success:^(ODReturenPointResultModel *resultModel) {
            
            if (resultModel) {
                
                [self.listArray addSafeObject:resultModel.list];
                
                if( resultModel.isEnd ){
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
                
                self.wp = resultModel.wp;
            }
            
            [self finishLoadMore];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishLoadMore];
            [self reloadData];
        }];;

    }else {
        
        [OrderRequest getReturenPointDataWithParams:params success:^(ODReturenPointResultModel *resultModel) {
            [self.listArray removeAllObjects];
            [self hideEmptyTips];
            if (resultModel) {
                self.resultModel = resultModel;
                [self.listArray addObjectsFromSafeArray:resultModel.list];
                
                if( resultModel.isEnd ){
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
                self.wp = resultModel.wp;
            }
            
            if (resultModel.list.count == 0) {
//                NSString *noticeStr = @"还没有返还淘米哦";
//                [self showEmptyTips:noticeStr ownerView:self.tableView];
                self.tableView.showsInfiniteScrolling = NO;
            }
            
            [self finishLoadMore];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishLoadMore];
            [self reloadData];
        }];;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else {
        return self.listArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        if (row == 0) {
            ODReturenPointHeaderCell *cell = [ODReturenPointHeaderCell dequeueReusableCellForTableView:tableView];
            cell.cellData = self.resultModel.plan;
            [cell reloadData];
            return cell;
        }
    }else if (section == 1) {
        ODReturnPointListCell *cell = [ODReturnPointListCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.listArray safeObjectAtIndex:row];
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
    
    if (section == 0 ) {
        if (row == 0) {
            height = [ODReturenPointHeaderCell heightForCell:self.resultModel.plan];
            
        }else {
            height = 10;
        }
    }else if (section == 1) {
        height = [ODReturnPointListCell heightForCell:[self.listArray safeObjectAtIndex:row]];
    }
    
    return height;
}






@end
