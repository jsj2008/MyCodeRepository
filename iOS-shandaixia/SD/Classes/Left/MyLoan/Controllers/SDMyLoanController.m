//
//  SDMyLoanController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDMyLoanController.h"
#import "SDMyLoanCell.h"
#import "SDLoanDetailController.h"
#import "SDMyLoan.h"


@interface SDMyLoanController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *loanTableView;

@property (nonatomic, strong) NSMutableArray *myLoan;

@end

@implementation SDMyLoanController

- (NSMutableArray *)myLoan{
    
    if (_myLoan == nil) {
        
        _myLoan = [NSMutableArray array];
    }
    
    return _myLoan;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = FDColor(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"我的借款"];
    
    [self loadMyLoan];
    
//    [self addView];
    
    [self addLoanTableView];
    
}

- (void)addLoanTableView{

    UITableView *loanTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    loanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.loanTableView = loanTableView;
//    loanTableView.bounces = NO;
    loanTableView.delegate = self;
    loanTableView.dataSource = self;
    loanTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:loanTableView];
    
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
//    
//    backView.backgroundColor = self.view.backgroundColor;
//    
//    
//    
//    [self.view addSubview:backView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.myLoan.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SDMyLoanCell *cell = [SDMyLoanCell cellWithTableView:tableView];
    
    cell.myLoan = self.myLoan[indexPath.row];
    
    if (indexPath.row == self.myLoan.count - 1) {
        
        cell.lineView.hidden = YES;
        
    }else{
    
        cell.lineView.hidden = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 120 * SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDLoanDetailController *loanDetailCon = [[SDLoanDetailController alloc] init];

    loanDetailCon.myLoan = self.myLoan[indexPath.row];
    
    [self.navigationController pushViewController:loanDetailCon animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20 * SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20 * SCALE)];
    view.backgroundColor = FDColor(240, 240, 240);
    
    return view;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //取消tableView 的header与footer的粘性
    if (scrollView == self.loanTableView)
        
    {
        
        UITableView *tableview = (UITableView *)scrollView;
        CGFloat sectionHeaderHeight = 20 * SCALE;
        CGFloat sectionFooterHeight = 20 * SCALE;
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

- (void)loadMyLoan{
    
    [SVProgressHUD show];

    [SDMyLoan getMyLoanfinishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        NSArray *array = object;
        
        if (array.count) {
            
            self.myLoan = array.copy;
            
            [self.loanTableView reloadData];
            
        }else{
            
            self.loanTableView.hidden = YES;
        
            [self noContentUIWithImageNamed:@"no_lending"];
        }
        
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
    }];
}



@end










