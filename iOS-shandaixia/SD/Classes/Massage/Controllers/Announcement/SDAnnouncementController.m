//
//  SDAnnouncementController.m
//  SD
//
//  Created by LayZhang on 2017/5/23.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDAnnouncementController.h"
#import "SDmassages.h"

#import "SDAnnouncementCell.h"
#import "SDAnnouncementDetailController.h"

@interface SDAnnouncementController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation SDAnnouncementController

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
    [self createNavBarWithTitle:@"公告消息"];
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
    SDMassages *message1 = [[SDMassages alloc] init];
    message1.ID = @"1";
    message1.pushType = @"1";
    message1.pushUrl = @"www.baidu.com";
    message1.gmtCreate = @"1";
    message1.name = @"name";
    message1.content = @"12312313123123123";
    message1.status = SDMassageStatusRead;
    
    SDMassages *message2 = [[SDMassages alloc] init];
    message2.ID = @"2";
    message2.pushType = @"1";
    message2.pushUrl = @"www.baidu.com";
    message2.gmtCreate = @"1";
    message2.name = @"name";
    message2.content = @"123123131231231231231231312312312312312313123123123";
    message2.status = SDMassageStatusRead;
    
    SDMassages *message3 = [[SDMassages alloc] init];
    message3.ID = @"3";
    message3.pushType = @"1";
    message3.pushUrl = @"www.baidu.com";
    message3.gmtCreate = @"1";
    message3.name = @"name";
    message3.content = @"12312313123123123123123131231231231231231312312312312312313123123123";
    message3.status = SDMassageStatusRead;
    NSArray *array = [NSArray arrayWithObjects:message1, message2, message3, nil];
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
    [tableView registerClass:[SDAnnouncementCell class] forCellReuseIdentifier:@"SDAnnouncementCell"];

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
    SDAnnouncementCell *cell = [SDAnnouncementCell cellWithTableView:tableView];
    [self configCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configCell:(SDAnnouncementCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO;
    cell.massages = self.messageArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDMassages *message = self.messageArray[indexPath.row] ;
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"SDAnnouncementCell" cacheByKey:message.ID configuration:^(SDAnnouncementCell *cell) {
        [self configCell:cell atIndexPath:indexPath];
    }];
    NSLog(@"height is %f", height);
    return height;
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

    SDAnnouncementDetailController *note = [[SDAnnouncementDetailController alloc] init];
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


@end
