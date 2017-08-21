//
//  StreetSnapViewController.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/10.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "StreetSnapViewController.h"
#import "StreetSnapRequest.h"
#import "StreetSnapBannerCell.h"
#import "StreetSnapItemCell.h"
#import "StreetSnapeBannerModel.h"

@interface StreetSnapViewController ()

@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) StreetSnapeBannerModel *bannerModel;
@end

@implementation StreetSnapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar];

    self.view.backgroundColor = Color_Gray245;

    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    
    self.title = @"全球街拍";
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
        [StreetSnapRequest getStreetSnapDataWithParams:params success:^(StreetSnapResultModel *resultModel) {
            if (resultModel) {
                [self.list addObjectsFromSafeArray:[self splitArray:resultModel.items.list withSubSize:3]];
                self.tableView.showsInfiniteScrolling = !resultModel.items.isEnd;
                self.wp = resultModel.items.wp;
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
        [StreetSnapRequest getStreetSnapDataWithParams:params success:^(StreetSnapResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyTips];
            if (resultModel) {
                
                [self.list addObjectsFromSafeArray:[self splitArray:resultModel.items.list withSubSize:3]];
                self.bannerModel = resultModel.banner;
                self.tableView.showsInfiniteScrolling = !resultModel.items.isEnd;
                self.wp = resultModel.items.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.items.list.count == 0) {
                [self showEmptyTips:@"当前没有商品"];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }else {
        return self.list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        StreetSnapBannerCell *cell = [StreetSnapBannerCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.bannerModel;
        [cell reloadData];
        return cell;
    }else if (indexPath.section == 1) {
        StreetSnapItemCell *cell = [StreetSnapItemCell dequeueReusableCellForTableView:tableView];
        NSArray *dataArr = [self.list safeObjectAtIndex:indexPath.row];
        cell.cellData = dataArr;
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
        
    if (indexPath.section ==0) {
        height = [StreetSnapBannerCell heightForCell:self.bannerModel];
        
    }else if (indexPath.section == 1) {
        NSArray *dataArr = [self.list safeObjectAtIndex:indexPath.row];
       height = [StreetSnapItemCell heightForCell:dataArr];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [[TTNavigationService sharedService]openUrl:self.bannerModel.link];
    }
}

- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize{
    
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        
        [arr1 removeAllObjects];
        
        int j = index;
        
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}

@end
