//
//  SDMassageController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDMassageController.h"
#import "SDActivityCell.h"
#import "SDMassages.h"
#import "MessageSumView.h"
#import "SDAnnouncementController.h"
#import "SDNoticeMessageController.h"

@interface SDMassageController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) MessageSumView *messageAnnounce; //公告咨询
@property (nonatomic, weak) MessageSumView *messageNotice; // 通知

@property (nonatomic, weak) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *benefitsArray;

@end

@implementation SDMassageController

- (NSMutableArray *)benefitsArray{

    if (_benefitsArray == nil) {
        _benefitsArray = [NSMutableArray array];
    }
    
    return _benefitsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = FDColor(243, 245, 249);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"消息中心"];
    
    [self addContentView];
    
    [self loanMassage];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)addContentView {
    
    MessageSumModel *messageModel = [[MessageSumModel alloc] init];
    messageModel.messageType = MessageTypeAnnounce;
    messageModel.time = @"time";
    messageModel.readStatus = YES;
    messageModel.content = @"contentcontentcontentcontentcontentcontentcontentcontentcontentcontent";
    messageModel.messageNum = 1233;
    
    MessageSumModel *messageModel01 = [[MessageSumModel alloc] init];
    messageModel01.messageType = MessageTypeNoticeMessage;
    messageModel01.time = @"time1";
    messageModel01.readStatus = YES;
    messageModel01.content = @"messageModel01messageModel01messageModel01messageModel01messageModel01messageModel01";
    messageModel01.messageNum = 12313213;
    
    // announce 公告
    MessageSumView *messageAnnounceView = [[MessageSumView alloc] init];
    [messageAnnounceView setFrame:CGRectMake(0, 64, SCREENWIDTH, 150 * SCALE)];
    [self.view addSubview:messageAnnounceView];
    self.messageAnnounce = messageAnnounceView;
    [messageAnnounceView addGestureRecognizer:[self tapGestureRecongnizer]];
    messageAnnounceView.messageModel = messageModel;
    
    // notification 通知
    MessageSumView *messageNoticeView = [[MessageSumView alloc] init];
    [messageNoticeView setFrame:CGRectMake(0, 150 * SCALE + 64, SCREENWIDTH, 150 * SCALE)];
    [self.view addSubview:messageNoticeView];
    self.messageNotice = messageNoticeView;
    [messageNoticeView addGestureRecognizer:[self tapGestureRecongnizer]];
    messageNoticeView.messageModel = messageModel01;
    
    // activite 活动
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 300 * SCALE, SCREENWIDTH, SCREENHEIGHT - 64 - 300 * SCALE) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = FDColor(243, 245, 249);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
}

- (void)loanMassage{
    
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
    message.content = @"1231231231312312312312312";
    message.status = SDMassageStatusRead;
    NSArray *array = [NSArray arrayWithObjects:message, message, message, nil];
    self.benefitsArray = array;
    
    
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

//- (void)addLoanTableView{
//    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView = tableView;
//    tableView.backgroundColor = FDColor(243, 245, 249);
//    
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
//    
//    
//    [backView addSubview:tableView];
//    
//    [self.view addSubview:backView];
//    
//    
//}
//
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return self.massageArray.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //创建cell
//    SDMassageCell *cell = [SDMassageCell cellWithTableView:tableView];
//    
//    cell.massages = self.massageArray[indexPath.section];
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 136 * SCALE;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    
//    return 20 * SCALE;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 20 * SCALE)];
//    view.backgroundColor = FDColor(243, 245, 249);
//    
//    return view;
//    
//}
//
//#pragma mark - 代理方法
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    
//    SDMassages *massage = self.massageArray[indexPath.section];
//    
//    
//    
//    
//    
//    
//    
//    SDNotificationController *note = [[SDNotificationController alloc] init];
//    note.massages = massage;
////    [self.navigationController pushViewController:note animated:YES];
//    
//    [self presentViewController:note animated:YES completion:nil];
//    
//    if (massage.status == SDMassageStatusUnRead) {
//        
//        massage.status = SDMassageStatusRead;
//        
//        self.massageArray[indexPath.section] = massage;
//        
//        [self.tableView reloadData];
//        
//        
//        [SDMassages readMassage:self.massageArray[indexPath.section] finishedBlock:^(id object) {
//            
//        } failuredBlock:^(id object) {
//            
//        }];
//    }
//    
//    
//}
//
//#pragma mark - 删除数据
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if(editingStyle == UITableViewCellEditingStyleDelete){
//        
//        self.view.userInteractionEnabled = NO;
//        
//        [SVProgressHUD showWithStatus:@"正在删除消息"];
//        
//        [SDMassages deleteMassage:self.massageArray[indexPath.section] finishedBlock:^(id object) {
//            
//            [SVProgressHUD dismiss];
//            
//            self.view.userInteractionEnabled = YES;
//            
//            if ([object[@"msg"] isEqualToString:@"成功"]) {
//                
//                [FDReminderView showWithString:@"删除成功"];
//                
//                //删除模型数据
//                [self.massageArray removeObjectAtIndex:indexPath.section];
//                
//                //刷新tableView
//                [self.tableView reloadData];
//                
//            }else{
//            
//                [FDReminderView showWithString:@"删除失败"];
//            }
//            
//            if (self.massageArray.count == 0) {
//                
//                [self noContentUIWithImageNamed:@"no_massages"];
//                
//            }
//            
//        } failuredBlock:^(id object) {
//            
//            [FDReminderView showWithString:@"删除失败"];
//            
//            [SVProgressHUD dismiss];
//            
//            self.view.userInteractionEnabled = YES;
//            
//        }];
//        
//        
//        
//        
//        
//        
//    }
//}
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    //取消tableView 的header与footer的粘性
//    if (scrollView == self.tableView)
//        
//    {
//        
//        UITableView *tableview = (UITableView *)scrollView;
//        CGFloat sectionHeaderHeight = 20 * SCALE;
//        CGFloat sectionFooterHeight = 20 * SCALE;
//        CGFloat offsetY = tableview.contentOffset.y;
//        
//        if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
//            
//        {
//            
//            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//            
//        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)
//            
//        {
//            
//            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//            
//        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)         {
//            
//            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
//            
//        }
//        
//    }
//}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.benefitsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //创建cell
    SDActivityCell *cell = [SDActivityCell cellWithTableView:tableView];
    cell.massages = self.benefitsArray[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300 * SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 100 * SCALE;;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100 * SCALE)];
    view.backgroundColor = FDColor(243, 245, 249);

    if (section == 0) {       
        UILabel *label = [[UILabel alloc] init];
        label.frame = view.frame;
        label.text = @"福利活动";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    return view;

}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



//    SDMassages *massage = self.benefitsArray[indexPath.row];
//
//
//
//
//
//
//
//    SDNotificationController *note = [[SDNotificationController alloc] init];
//    note.massages = massage;
////    [self.navigationController pushViewController:note animated:YES];
//
//    [self presentViewController:note animated:YES completion:nil];
//
//    if (massage.status == SDMassageStatusUnRead) {
//
//        massage.status = SDMassageStatusRead;
//
//        self.benefitsArray[indexPath.row] = massage;
//
//        [self.tableView reloadData];
//
//
//        [SDMassages readMassage:self.benefitsArray[indexPath.row] finishedBlock:^(id object) {
//
//        } failuredBlock:^(id object) {
//
//        }];
//    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    //取消tableView 的header与footer的粘性
//    if (scrollView == self.tableView) {
//
//        UITableView *tableview = (UITableView *)scrollView;
//        CGFloat sectionHeaderHeight = 20 * SCALE;
//        CGFloat sectionFooterHeight = 20 * SCALE;
//        CGFloat offsetY = tableview.contentOffset.y;
//
//        if (offsetY >= 0 && offsetY <= sectionHeaderHeight) {
//            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
//        }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight) {
//
//            tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
//
//        }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)         {
//
//            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
//        }
//    }
//}


#pragma mark - actions
- (void)leftBtnDidTouch{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITapGestureRecognizer *)tapGestureRecongnizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseMessage:)];
    return tap;
}

-(void)chooseMessage:(UITapGestureRecognizer *)recognizer {
    if (recognizer.view == self.messageNotice) {
        SDNoticeMessageController *noticeMessageController = [[SDNoticeMessageController alloc] init];
        
        [self presentViewController:noticeMessageController animated:YES completion:nil];
    }
    
    if (recognizer.view == self.messageAnnounce) {
        SDAnnouncementController *annoucementController = [[SDAnnouncementController alloc] init];
        [self presentViewController:annoucementController animated:YES completion:nil];
    }
}

@end
