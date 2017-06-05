//
//  SDSignatureSettingController.m
//  SD
//
//  Created by LayZhang on 2017/5/8.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDSignatureSettingController.h"
#import "SDEleSignatureCell.h"
#import "SDSignatureFirstAlertView.h"
#import "SDUserInfo.h"
#import "SDSSQStatus.h"

@interface SDSignatureSettingController ()<UITableViewDelegate, UITableViewDataSource, SDEleSignatureCellDelegate, UIAlertViewDelegate>

// 1 是自动签署 0 是手动签署
@property (nonatomic, assign) SSQSatusCode ssqStatusCode;

@end

@implementation SDSignatureSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"电子签名"];
    [self addEleSignatureSwitchTableView];
    
    [self showIsFirst];
    
    [self reloadSSQStatus];
    
    [SDNotificationCenter addObserver:self
                             selector:@selector(reloadSSQStatus)
                                 name:SDSSQqueryStatus
                               object:nil];
}

- (void)addEleSignatureSwitchTableView{
    
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

- (void)showIsFirst {
    NSString *isFirst = [FDUserDefaults objectForKey:SDEleSignatureIsFirst];
    if (![isFirst isEqualToString:@"FALSE"]) {
        [SDSignatureFirstAlertView show];
        [FDUserDefaults setObject:@"FALSE" forKey:SDEleSignatureIsFirst];
        [FDUserDefaults synchronize];
    }
}

#pragma mark - property
- (NSArray *)groups {
    if (_groups == nil) {
        NSMutableDictionary *item0 = [[NSMutableDictionary alloc] init];
        [item0 setObject:@"自动签署" forKey:@"Title"];
        [item0 setObject:@"UISwitch" forKey:@"AccessoryType"];
        
        NSMutableDictionary *item1 = [[NSMutableDictionary alloc] init];
        [item1 setObject:@"默认签名" forKey:@"Title"];
        if (self.realName) {
            [item1 setObject:self.realName forKey:@"STitle"];
        } else {
            [item1 setObject:@"" forKey:@"STitle"];
        }
        [item1 setObject:@"" forKey:@"AccessoryType"];
        
        NSArray *itemArray;
        
        switch (self.ssqStatusCode) {
                case SSQSatusCodeAuto:
                [item0 setObject:@"TRUE" forKey:@"Value"];
                itemArray = [NSArray arrayWithObjects:item0,item1, nil];
                break;
                case SSQSatusCodeManual:
                [item0 setObject:@"FALSE" forKey:@"Value"];
                itemArray = [NSArray arrayWithObjects:item0, nil];
                break;
                
            default:
                break;
        }
        _groups = [NSArray arrayWithObjects:itemArray, nil];
    }
    return _groups;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *items = self.groups[section];
    
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    SDEleSignatureCell *cell = [SDEleSignatureCell cellWithTableView:tableView];
    
    //获取数据
    cell.item = self.groups[indexPath.section][indexPath.row];
    
    cell.delegate = self;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60 * SCALE;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGFloat height = 80 * SCALE;
    CGFloat edge = 30 * SCALE;
    UIView *footView = [[UIView alloc] init];
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(edge, 5, SCREENWIDTH - 2 * edge, height - 5)];
    warningLabel.numberOfLines = 0;
    
    NSString *onString = @"您当前已开启自动签署，您借款生成的每份协议，都将自动选择默认签名完成签署。";
    NSString *offString = @"您当前已关闭自动签署，您借款生成的每份协议，都需要手动操作才能完成。";
    warningLabel.textColor = UIColor.grayColor;
    warningLabel.font = [UIFont systemFontOfSize:20 * SCALE];
    //    NSString *isOn = [FDUserDefaults objectForKey:SDEleSignatureSwitch];
    switch (self.ssqStatusCode) {
            case SSQSatusCodeAuto:
            warningLabel.text = onString;
            
            break;
            case SSQSatusCodeManual:
            warningLabel.text = offString;
            break;
            
        default:
            break;
    }
    
    [footView addSubview:warningLabel];
    return footView;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)eleSignatureCellGestureSwitch:(UISwitch *)sender {
    
    if (sender.on) {
        self.ssqStatusCode = SSQSatusCodeAuto;
        [self sendUpdateNotification];
    } else {
        self.ssqStatusCode = SSQSatusCodeManual;
        sender.on = true;
        [self showAlert];
    }
}

- (void)showAlert {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                       message:@"关闭自动签署后，您每次借款将需要手动签署闪贷侠借款服务协议才能借款"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma mark - alert delegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self sendUpdateNotification];
    }
}

- (void)sendUpdateNotification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SDNotificationCenter postNotificationName:SDSSQUpdateStatus
                                            object:[NSNumber numberWithInteger:self.ssqStatusCode]];
    });
}

#pragma mark - notification
- (void)reloadSSQStatus {
    [SVProgressHUD show];
    
    [SDSSQStatus querySSQStatusFinishedBlock:^(id object) {
        [SVProgressHUD dismiss];
        self.ssqStatusCode = [object integerValue];
        _groups = nil;
        [self.tableView reloadData];
    } failuredBlock:^(id object) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - super
- (void)dealloc {
    [SDNotificationCenter removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
