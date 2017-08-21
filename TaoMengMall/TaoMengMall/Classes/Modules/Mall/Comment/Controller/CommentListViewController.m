//
//  CommentListViewController.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentListResultModel.h"
#import "CommentFeedModel.h"

#import "CommentCell.h"
#import "CommentDSRCell.h"

#import "CommentRequest.h"

#define DSR_ROW 0


@interface CommentListViewController ()
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) CommentDSRModel *dsrModel;
@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color_Gray245;
    [self addNavigationBar];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 50, 20);
    [infoButton setImage:[UIImage imageNamed:@"btn_cart"] forState:UIControlStateNormal];
    [infoButton setImage:[UIImage imageNamed:@"btn_cart_unempty"] forState:UIControlStateSelected];
    [infoButton addTarget:self action:@selector(handleShowCartButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.rightBarButton = infoButton;
    
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    
    self.title = @"所有评价";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UIButton*)self.navigationBar.rightBarButton).selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cartHasItems"] isEqualToString:@"1"];
    [self initData];
    
}

#pragma mark - Private Methods

- (void)initData
{
    self.comments = [NSMutableArray<CommentFeedModel> array];
    self.loadingType = kInit;
    [self loadData];
}

#pragma mark - Event Response

- (void) handleShowCartButton
{
    [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"mallCart")];
}

- (void)loadData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:self.extraParams];
    
    self.tableView.showsInfiniteScrolling = NO;
    
    [params setSafeObject:self.itemId forKey:@"itemId"];

    if ( kLoadMore == self.loadingType ) {
        
        [params setSafeObject:self.wp forKey:@"wp"];
        
        [CommentRequest getCommentListMoreWithParams:params success:^(CommentListResultModel *resultModel) {
            
            if ( resultModel && resultModel.comments ) {
                
                [self.comments addObjectsFromSafeArray:resultModel.comments.list];
                
                self.wp = resultModel.comments.wp;
                
                if ( resultModel.comments.isEnd ) {
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
            }
            [self finishLoadMore];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            
            DBG(@"%@", status);
            [self finishLoadMore];
            [self reloadData];
        }];
        
    } else {
        //self.itemId = @"12q";
        //[params setSafeObject:self.itemId forKey:@"itemId"];
        [CommentRequest getCommentListWithParams:params success:^(CommentListResultModel *resultModel) {
            
            [self.comments removeAllObjects];
            [self hideEmptyTips];
            
            if ( resultModel ) {
                
                [self.comments addObjectsFromSafeArray:resultModel.comments.list];
                self.dsrModel = resultModel.dsr;
                self.wp = resultModel.comments.wp;
                
                if ( resultModel.comments.isEnd ) {
                    self.tableView.showsInfiniteScrolling = NO;
                } else {
                    self.tableView.showsInfiniteScrolling = YES;
                }
                
            } else {
                NSString *noticeStr = @"还没有评论哦";
                [self showEmptyTips:noticeStr ownerView:self.tableView];
                self.tableView.showsInfiniteScrolling = NO;
            }
            
            [self finishRefresh];
            [self reloadData];

        } failure:^(StatusModel *status) {
            
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
        }];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (DSR_ROW == row) {
        CommentDSRCell *cell = [CommentDSRCell dequeueReusableCellForTableView:tableView];
        cell.cellData = self.dsrModel;
        [cell reloadData];
        return cell;
    }else{
        CommentFeedModel *comment = [self.comments safeObjectAtIndex:indexPath.row -1];
        CommentCell *cell = [CommentCell dequeueReusableCellForTableView:tableView];
        cell.cellData = comment;
        [cell reloadData];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    NSInteger row = indexPath.row;
    if (DSR_ROW == row) {
        height = [CommentDSRCell heightForCell:self.dsrModel];
    }else{
        CommentFeedModel *comment = [self.comments safeObjectAtIndex:indexPath.row-1];
        height = [CommentCell heightForCell:comment];
    }
    
    return height;
}

#pragma mark - TTErrorTipsViewDelegate

- (void) errorTipsViewBeginRefresh:(TTErrorTipsView *)tipsView
{
    [self initData];
}

@end
