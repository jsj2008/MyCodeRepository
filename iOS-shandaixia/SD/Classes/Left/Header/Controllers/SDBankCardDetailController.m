//
//  SDBankCardDetailController.m
//  SD
//
//  Created by 余艾星 on 17/3/6.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDBankCardDetailController.h"
#import "SDBankCardDetailCell.h"
#import "FDAlertView.h"

#import "SDLoginAlertView.h"

@interface SDBankCardDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;



@property (nonatomic, weak) SDLoginAlertView *alertView;



@end

@implementation SDBankCardDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavBarWithTitle:@"银行卡"];
    
    
    
    [self addLoanTableView];
    
    
    [self addUnbindButton];
}



- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = self.view.backgroundColor = FDColor(243, 245, 249);
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    SDBankCardDetailCell *cell = [SDBankCardDetailCell cellWithTableView:tableView];
    
    cell.bankCard = self.bankCard;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    return 228 * SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setBankCard:(SDBankCard *)bankCard{

    _bankCard = bankCard;
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20 * SCALE;
}

- (void)addUnbindButton{

    UIView *unbindView = [[UIView alloc] initWithFrame:CGRectMake(0, (228 + 70) * SCALE + 64, SCREENWIDTH, 100 * SCALE)];
    UIButton *unbindButton = [UIButton buttonWithTitle:@"解  绑" titleColor:FDColor(34, 34, 34) titleFont:30 * SCALE];
    unbindButton.frame = unbindView.frame;
    unbindButton.y = 0;
    [unbindView addSubview:unbindButton];
    unbindButton.backgroundColor = SDWhiteColor;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1 * SCALE)];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, unbindView.height - 1 * SCALE, SCREENWIDTH, 1 * SCALE)];
    line1.backgroundColor = line2.backgroundColor = FDColor(230, 230, 230);
    [unbindView addSubview:line1];
    [unbindView addSubview:line2];
    
    [self.view addSubview:unbindView];
    
    [unbindButton addTarget:self action:@selector(unbindButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)unbindButtonDidClicked:(UIButton *)button{
    
//    FDAlertView *alertView = [[FDAlertView alloc] init];
//    self.alertView = alertView;
//    alertView.titleLabel.text = @"确定删除该银行卡？";
//    
//    [alertView.leftButton setTitle:@"取消" forState:UIControlStateNormal];
//    [alertView.rightButton setTitle:@"确认" forState:UIControlStateNormal];
//    
//    [alertView.leftButton addTarget:self action:@selector(cancelLogout) forControlEvents:UIControlEventTouchUpInside];
//    [alertView.rightButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
//    
//    [alertView show];
    
    
    CGFloat w = 578 * SCALE;
    CGFloat x = (SCREENWIDTH - w)/2;

    SDLoginAlertView *alertView = [[SDLoginAlertView alloc] initWithFrame:CGRectMake(x, 0, w, 380 * SCALE)];
    self.alertView = alertView;
    
    alertView.passwordTextField.text = @"确定解绑该银行卡？";
    
    [alertView.sureButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    [alertView show];

    

    
    
}

- (void)logout{
    
    [self.alertView remove];
    
    [SVProgressHUD showWithStatus:@"正在解绑"];
    
    [SDBankCard unbundleWithCardNumber:self.bankCard.ID finishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        NSString *str = object[@"msg"];
        
        if ([str containsString:@"成功"]) {
            
            
            [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"解绑成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [SVProgressHUD dismiss];
                
            });
            
            [SDNotificationCenter postNotificationName:SDBankCardChangedNotification object:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            
            [FDReminderView showWithString:str];
        }
        
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        NSString *str = object[@"msg"];
        
        [FDReminderView showWithString:str];
    }];
    
    
}


@end
