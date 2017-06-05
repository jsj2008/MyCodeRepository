//
//  SDCityController.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDCityController.h"
#import "YAXSettingCell.h"
#import "SDCity.h"
#import "SDGJJController.h"

@interface SDCityController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SDCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"认证"];
    
    
    
    
    
}

- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = SDWhiteColor;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.city.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    YAXSettingCell *cell = [YAXSettingCell cellWithTableView:tableView];
    
    SDCity *city = self.city[indexPath.row];
    cell.textLabel.text = city.name;
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100 * SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20 * SCALE;
}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDGJJController *gjjCon = [[SDGJJController alloc] init];
    gjjCon.channelType = self.channelType;
    gjjCon.city = self.city[indexPath.row];
    [gjjCon getData];
    [self.navigationController pushViewController:gjjCon animated:YES];
    
//    //取消选中效果
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 当屏幕滚动时调用的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //取消tableView 的header与footer的粘性
    if (scrollView == self.tableView)
        
    {
        
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderHeight = 64;
        CGFloat sectionFooterHeight = 20*SCALE;
        CGFloat offsetY = tableview.contentOffset.y;
        
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
            
        {
            
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
            
        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
            
        {
            
            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
            
        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)         {
            
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
            
        }
        
    }
    
}


@end
