//
//  SDNoticeMessageController.m
//  SD
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDNoticeMessageController.h"
#import "SDMassages.h"
#import "SDNoticeMessageCell.h"
#import "SDNoticeMessageDetailController.h"

@interface SDNoticeMessageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation SDNoticeMessageController

#pragma mark - property
- (NSMutableArray *)messageArray {
    if (_messageArray == nil) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

#pragma mark - system load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:@"系统消息"];
    [self addLoanTableView];
    [self loadMassage];
}

#pragma mark - loadData
- (void)loadMassage{
    
    //    [SVProgressHUD show];
    
    //模拟数据
    //    @property (nonatomic, copy) NSString *ID;
    //    @property (nonatomic, copy) NSString *pushType;
    //    @property (nonatomic, copy) NSString *pushUrl;
    //    @property (nonatomic, copy) NSString *gmtCreate;
    //    @property (nonatomic, copy) NSString *name;
    //    @property (nonatomic, copy) NSString *content;
    //    @property (nonatomic, assign) SDMassageStatus status;
    SDMassages *message = [[SDMassages alloc] init];
    message.ID = @"123";
    message.pushType = @"1";
    message.pushUrl = @"www.baidu.com";
    message.gmtCreate = @"1";
    message.name = @"name";
    message.content = @"123123123131231231231231212312312313123123123123121231231231312312312312312123123123131231231231231212312312313123123123123121231231231312312312312312";
    message.status = SDMassageStatusRead;
    NSArray *array = [NSArray arrayWithObjects:message, message, message, nil];
    self.messageArray = array;
    
    
    //    [SDMassages getMassages:1 finishedBlock:^(id object) {
    //
    //        [SVProgressHUD dismiss];
    //
    //        NSArray *array = object;
    //
    //        if (array.count) {
    //
    //            [self.massageArray addObjectsFromArray:object];
    //            [self.tableView reloadData];
    //        }else{
    //
    //            [self noContentUIWithImageNamed:@"no_massages"];
    //        }
    //
    //    } failuredBlock:^(id object) {
    //
    //        [SVProgressHUD dismiss];
    //    }];
}

#pragma mark - init component
- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = FDColor(243, 245, 249);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerClass:[SDNoticeMessageCell class] forCellReuseIdentifier:@"SDNoticeMessageCell"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    SDNoticeMessageCell *cell = [SDNoticeMessageCell cellWithTableView:tableView];
    
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configCell:(SDNoticeMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    cell.massages = self.messageArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 136 * SCALE;
    SDMassages *message = self.messageArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:@"SDNoticeMessageCell"
                                          cacheByKey:message.ID
                                       configuration:^(SDNoticeMessageCell *cell) {
                                           [self configCell:cell atIndexPath:indexPath];
                                       }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20 * SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20 * SCALE)];
    view.backgroundColor = FDColor(243, 245, 249);
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SDMassages *message = self.messageArray[indexPath.row];
    
    SDNoticeMessageDetailController *note = [[SDNoticeMessageDetailController alloc] init];
    note.massages = message;
    //    [self.navigationController pushViewController:note animated:YES];
    
    [self presentViewController:note animated:YES completion:nil];
    
    if (message.status == SDMassageStatusUnRead) {
        
        message.status = SDMassageStatusRead;
        
        self.messageArray[indexPath.row] = message;
        
        [self.tableView reloadData];
        
        [SDMassages readMassage:self.messageArray[indexPath.row] finishedBlock:^(id object) {
            
        } failuredBlock:^(id object) {
            
        }];
    }
}

#pragma mark - 删除数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        self.view.userInteractionEnabled = NO;
        
        [SVProgressHUD showWithStatus:@"正在删除消息"];
        
        [SDMassages deleteMassage:self.messageArray[indexPath.row] finishedBlock:^(id object) {
            
            [SVProgressHUD dismiss];
            
            self.view.userInteractionEnabled = YES;
            
            if ([object[@"msg"] isEqualToString:@"成功"]) {
                
                [FDReminderView showWithString:@"删除成功"];
                
                //删除模型数据
                [self.messageArray removeObjectAtIndex:indexPath.row];
                
                //刷新tableView
                [self.tableView reloadData];
                
            }else{
                
                [FDReminderView showWithString:@"删除失败"];
            }
            
            if (self.messageArray.count == 0) {
                
                [self noContentUIWithImageNamed:@"no_messages"];
                
            }
            
        } failuredBlock:^(id object) {
            
            [FDReminderView showWithString:@"删除失败"];
            
            [SVProgressHUD dismiss];
            
            self.view.userInteractionEnabled = YES;
        }];
    }
}

- (void)leftBtnDidTouch {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
