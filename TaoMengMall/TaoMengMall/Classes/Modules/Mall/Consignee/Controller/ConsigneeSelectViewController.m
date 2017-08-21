//
//  ConsigneeSelectViewController.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ConsigneeSelectViewController.h"
#import "ConsigneeEditViewController.h"
#import "ConsigneeRequest.h"
#import "ConsigneeCell.h"
#import "XMAppThemeHelper.h"

NSString *const kNOTIFY_CART_CONSIGNEE_SELECT = @"kNOTIFY_CART_CONSIGNEE_SELECT";

@interface ConsigneeSelectViewController () <ConsigneeCellDelegate>

@property (nonatomic, strong) NSMutableArray<ConsigneeModel> *consignees;
@property (nonatomic, strong) ConsigneeModel *currentConsignee;
@end

@implementation ConsigneeSelectViewController

#pragma mark - Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = Color_Gray245;

    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 56, 20);
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[XMAppThemeHelper defaultTheme].navigationBarButtonColor forState:UIControlStateNormal];
    addButton.titleLabel.font = FONT(16);
    [addButton addTarget:self action:@selector(handleAddButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationBar.rightBarButton = addButton;
    
    self.title = @"选择收货地址";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:kNOTIFY_CART_CONSIGNEE_EDIT_CREATE object:nil];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initData];
    
}

#pragma mark - Private Methods

- (void)initData
{
    self.consignees = [NSMutableArray<ConsigneeModel> array];
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    if ( kLoadMore == self.loadingType ) {
        
        [params setSafeObject:self.wp forKey:@"wp"];
    
        [ConsigneeRequest getConsigneeListMoreWithParams:params success:^(ConsigneeListResultModel *resultModel) {
            
            if ( resultModel && resultModel.consignees ) {
                
                [self.consignees addObjectsFromSafeArray:resultModel.consignees.list];
                
                self.wp = resultModel.consignees.wp;
                
                if ( resultModel.consignees.isEnd ) {
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
            }

            [self finishLoadMore];
            
        } failure:^(StatusModel *status) {
            
            DBG(@"%@", status);
            [self finishLoadMore];
            
        }];
        
    } else {
    
        [ConsigneeRequest getConsigneeListWithParams:params success:^(ConsigneeListResultModel *resultModel) {
            
            [self.consignees removeAllObjects];
            [self hideEmptyTips];
            
            if ( resultModel && resultModel.consignees && resultModel.consignees.list && resultModel.consignees.list.count > 0 ) {
                
                [self.consignees addObjectsFromSafeArray:resultModel.consignees.list];
                
                self.wp = resultModel.consignees.wp;
                
                if ( resultModel.consignees.isEnd ) {
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
                
                [self reloadData];
                
            } else {
                
                NSString *noticeStr = @"您还没有联系人信息哦，请点击右上角添加";
                [self showEmptyTips:noticeStr ownerView:self.tableView];
                self.tableView.showsInfiniteScrolling = NO;
                
            }
            
//            [self hideErrorTips];
            [self finishRefresh];
            
        } failure:^(StatusModel *status) {
            
//            [self showErrorTips];
            [self showNotice:status.msg];
            [self finishRefresh];
            
        }];
        
    }
    
}

#pragma mark - Event Response

- (void) handleAddButton {
    
    [[TTNavigationService sharedService] openUrl:@"xiaoma://consigneeEdit"];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.consignees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsigneeModel *consignee = [self.consignees safeObjectAtIndex:indexPath.row];
    
    ConsigneeCell *cell = [ConsigneeCell dequeueReusableCellForTableView:tableView];
    cell.cellData = consignee;
    cell.delegate = self;
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsigneeModel *consignee = [self.consignees safeObjectAtIndex:indexPath.row];
    
    CGFloat height = [ConsigneeCell heightForCell:consignee];
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsigneeModel *consignee = [self.consignees safeObjectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_CONSIGNEE_SELECT object:nil userInfo:@{@"consignee":consignee}];
    
    [self doBack];
    
    DBG(@"%@", consignee);
    
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

#pragma mark -click back
- (void)clickback
{
    ConsigneeModel *consignee = nil;
    for (ConsigneeModel *model in self.consignees) {
        if (model.isDefault) {
            consignee = model;
        }
    }
    if (consignee) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_CONSIGNEE_SELECT object:nil userInfo:@{@"consignee":consignee}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_CART_CONSIGNEE_SELECT object:nil userInfo:nil];
    }
    
    [self doBack];
}

- (void)doBack
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ConsigneeCellDelegate

- (void) defaultButtonDidTappedWithConsignee:(ConsigneeModel *)consignee {
    
    if (consignee) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setSafeObject:consignee.consigneeId forKey:@"consigneeId"];
        
        [ConsigneeRequest setDefaultWithParams:params success:^{
            
//            [self initData];
            
            for (ConsigneeModel *c in self.consignees) {
                
                if ( [c.consigneeId isEqualToString:consignee.consigneeId]) {
                    c.isDefault = YES;
                } else {
                    c.isDefault = NO;
                }
                
            }
            
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            
        }];
        
    }
    
}

- (void) editButtonDidTappedWithConsignee:(ConsigneeModel *)consignee {
    
    if (consignee && consignee.consigneeId) {
        [[TTNavigationService sharedService] openUrl:[NSString stringWithFormat:@"xiaoma://consigneeEdit?consigneeId=%@", consignee.consigneeId]];
    }
    
}

- (void) deleteButtonDidTappedWithConsignee:(ConsigneeModel *)consignee
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该收货地址？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    self.currentConsignee = consignee;
}

#pragma mark - 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.firstOtherButtonIndex == buttonIndex) {
        [self deleteAction];
    }
}

#pragma mark -
- (void)deleteAction
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.currentConsignee.consigneeId forKey:@"consigneeId"];
    
    [ConsigneeRequest deleteWithParams:params success:^{
        
        for (ConsigneeModel *c in self.consignees) {
            
            if ( [c.consigneeId isEqualToString:self.currentConsignee.consigneeId]) {
                
                [self.consignees removeObject:c];
                break;
            }
        }
        
        [self reloadData];
        self.currentConsignee = nil;
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
    }];
}
@end
