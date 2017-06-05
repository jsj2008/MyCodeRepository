//
//  SDSettingController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//
#define YAXTitle              @"YAXTitle"
#define YAXIcon               @"YAXIcon"
#define YAXAccessoryType      @"YAXAccessoryType"
#define YAXAccessoryName      @"YAXAccessoryName"
#define YAXTargetVc           @"YAXTargetVc"
#define YAXPlistName          @"YAXPlistName"
#define YAXSwitchKey          @"YAXSwitchKey"
#define YAXItems              @"YAXItems"
#define YAXHeader             @"YAXHeader"


#import "SDSettingController.h"
#import "YAXSettingCell.h"
#import "SDAboutUsController.h"
#import "SDVerifyPasswordView.h"
#import "SDUserInfo.h"
#import "SDLoginController.h"
#import "FDAlertView.h"
#import "SDAccount.h"
#import "SDResetPasswordController.h"
#import "SDGestureController.h"
#import "SDLoginAlertView.h"

@interface SDSettingController ()<UITableViewDataSource,UITableViewDelegate,SDVerifyPasswordViewDelegate,YAXSettingCellDelegate>


@property (nonatomic, weak) SDVerifyPasswordView *verifyView;

@property (nonatomic, weak) SDLoginAlertView *alertView;


@end

@implementation SDSettingController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"设置"];
    
    [self addLoanTableView];
    

    
}

- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = FDColor(240, 240, 240);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}

#pragma mark - 懒加载
- (NSArray *)groups{
    
    if (_groups == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];
        _groups = [NSArray arrayWithContentsOfFile:path];
        
    }
    return _groups;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *items = self.groups[section][YAXItems];
    
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    YAXSettingCell *cell = [YAXSettingCell cellWithTableView:tableView];
    
    //获取数据
    cell.item = self.groups[indexPath.section][YAXItems][indexPath.row];
    
    cell.delegate = self;
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        
//        cell.contentLabel.text = [NSString stringWithFormat:@"%.2f M",([[SDImageCache sharedImageCache] getSize]/(CGFloat)1000000)];
        
        if ([self.plistName isEqualToString:@"YAXSetting"]) {
            
            UIButton *outButton = [UIButton buttonWithTitle:@"退出" titleColor:FDColor(237, 71, 67) titleFont:36 * SCALE];
            
            outButton.frame = CGRectMake(0, 0, SCREENWIDTH, 100 * SCALE);
            
            [outButton addTarget:self action:@selector(outButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:outButton];
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100 * SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        return 40 * SCALE;
    }
    
    return 20 * SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat height = 20 * SCALE;
    if (section == 2) {
        
        height = 40 * SCALE;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    view.backgroundColor = FDColor(240, 240, 240);
    
    return view;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        SDAboutUsController *aboutUsController = [[SDAboutUsController alloc] init];
        
        aboutUsController.plistName = @"FDAboutUs";
        
        aboutUsController.title = @"关于我们";
        
        [self.navigationController pushViewController:aboutUsController animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        SDUserInfo *userInfo = [SDUserInfo getUserInfo];
        
        SDResetPasswordController *reset = [[SDResetPasswordController alloc] init];
        
        reset.oldPassword = userInfo.pwd;
        
        if (userInfo.pwd.length) {
            
            reset.massageType = 3;
        }else{
        
            reset.massageType = 2;
        
        }
        
        
        [self.navigationController pushViewController:reset animated:YES];
     
//        CGFloat w = 578 * SCALE;
//        CGFloat x = (SCREENWIDTH - w)/2;
//        
//        
//        
//        if (userInfo.pwd.length) {
//            
//            SDVerifyPasswordView *verifyView = [[SDVerifyPasswordView alloc] initWithFrame:CGRectMake(x, 0, w, 380 * SCALE)];
//            self.verifyView = verifyView;
//            verifyView.layer.cornerRadius = 10 * SCALE;
//            verifyView.clipsToBounds = YES;
//            verifyView.delegate = self;
//            [verifyView show];
//        }else{
//        
//            SDResetPasswordController *reset = [[SDResetPasswordController alloc] init];
//            
//            reset.massageType = 2;
//            
//            [self.navigationController pushViewController:reset animated:YES];
//        }

        
        
        
    }
    
    else if (indexPath.section == 0 && indexPath.row == 0) {
        
        

        
    }
    
    if (indexPath.section == 2) {
        
        
        
    }
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)outButtonDidClicked{

    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    if ([userInfo.ID isEqualToString: @""] || userInfo.ID == nil) {
        
        [FDReminderView showWithString:@"请先登录"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
            
        });
        
    }else{
//        FDAlertView *alertView = [[FDAlertView alloc] init];
//        self.alertView = alertView;
//        alertView.titleLabel.text = @"确定退出吗 ?";
//        
//        [alertView.leftButton setTitle:@"取消" forState:UIControlStateNormal];
//        [alertView.rightButton setTitle:@"确定" forState:UIControlStateNormal];
//        
//        [alertView.leftButton addTarget:self action:@selector(cancelLogout) forControlEvents:UIControlEventTouchUpInside];
//        [alertView.rightButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
//        
//        [alertView show];
        
        
        CGFloat w = 578 * SCALE;
        CGFloat x = (SCREENWIDTH - w)/2;
        
        SDLoginAlertView *alertView = [[SDLoginAlertView alloc] initWithFrame:CGRectMake(x, 0, w, 380 * SCALE)];
        self.alertView = alertView;
        alertView.passwordTextField.text = @"确定退出吗 ?";
        
        [alertView.sureButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
        [alertView show];
        
        
        
    }
    
    
}


- (void)logout{
    
    [self.alertView remove];
    
    [FDUserDefaults setObject:@"0" forKey:SDOpenGusturePassword];
    [FDUserDefaults setObject:nil forKey:SDGusturePassword];
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];

//    [FDReminderView showWithString:@"退出成功"];
    
    [SVProgressHUD showImage:[UIImage imageNamed:@"icon_OK"] status:@"退出成功"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
    });
    
    userInfo.ID = nil;
    
    [userInfo saveUserInfo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    [SDNotificationCenter postNotificationName:SDLogoutNotification object:nil];
}

- (void)verifyViewPasswordSuccess:(NSString *)password{

    SDResetPasswordController *reset = [[SDResetPasswordController alloc] init];
    
    reset.oldPassword = password;
    reset.massageType = 3;
    
    [self.navigationController pushViewController:reset animated:YES];
}

- (void)settingCellGestureSwitchOn{

    [self presentViewController:[[SDGestureController alloc] init] animated:YES completion:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

@end
