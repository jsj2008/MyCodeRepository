//
//  CaptureItemDetailViewController.m
//  FlyLantern
//
//  Created by marco on 24/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "CaptureItemDetailViewController.h"
#import "CIItemRequest.h"
#import "CIDetailTextCell.h"
#import "CIDetailImageCell.h"

@interface CaptureItemDetailViewController ()
@property (nonatomic, strong) NSArray *list;
@end

@implementation CaptureItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.showsPullToRefresh = YES;
    
    self.title = @"图文详情";
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setSafeObject:self.activityId forKey:@"activityId"];
    [CIItemRequest getPrizeDetailWithParams:params success:^(CIPrizeDetailResultModel *resultModel) {
        self.list = resultModel.list;
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        CIDetailContentModel *itemContent = [self.list safeObjectAtIndex:row];
        
        if ( itemContent ) {
            
            if ( [@"image" isEqualToString:itemContent.type] ) {
                
                CIDetailImageCell *cell = [CIDetailImageCell dequeueReusableCellForTableView:tableView];
                cell.cellData = itemContent;
                [cell reloadData];
                return cell;
                
            } else if ( [@"text" isEqualToString:itemContent.type] ) {
                CIDetailTextCell *cell = [CIDetailTextCell dequeueReusableCellForTableView:tableView];
                cell.cellData = itemContent.text;
                [cell reloadData];
                return cell;
            }
            
        }
    }
    
    
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0) {
        CIDetailContentModel *itemContent = [self.list safeObjectAtIndex:row];
        
        if ( itemContent ) {
            
            if ( [@"image" isEqualToString:itemContent.type]) {
                
                height = [CIDetailImageCell heightForCell:itemContent];
                
            } else if ( [@"text" isEqualToString:itemContent.type] ) {
                
                height = [CIDetailTextCell heightForCell:itemContent.text];
                
            }
            
        }
    }
    return height;
}
@end
