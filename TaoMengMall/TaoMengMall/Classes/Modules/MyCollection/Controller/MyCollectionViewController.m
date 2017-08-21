//
//  MyCollectionViewController.m
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionRequest.h"
#import "MyCollectionItemCell.h"

@interface MyCollectionViewController ()

@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,assign) BOOL isEditing;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *deleteLabel;
@property (nonatomic,strong) NSArray *selectArray;

@property (nonatomic,strong) UIView *emptyView;
@property (nonatomic,strong) UIImageView *emptyImage;
@property (nonatomic,strong) UILabel *emptyLabel;
@end

@implementation MyCollectionViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    self.view.backgroundColor = Color_Gray245;
    
    self.tableView.showsPullToRefresh = YES;
    self.tableView.showsInfiniteScrolling = NO;
    self.tableView.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT;
    
    [self render];
    [self initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEditing:) name:@"kNOTIFY_COLLECTION_EDIT_CHANGE" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectItem:) name:@"kNOTIFY_COLLECTION_ITEM_SELECT_CHANGE" object:nil];
    
   
}

- (void)render
{
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.deleteLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)changeEditing:(NSNotification *)noti
{
    self.isEditing = [noti.object boolValue];
    
    if (self.isEditing) {
        self.bottomView.hidden = NO;
    }else {
        self.bottomView.hidden = YES;
    }
    
    [self reloadData];
    
    
}

- (void)selectItem:(NSNotification *)noti
{
//    NSDictionary *dic = noti.object;
//    NSString *type = [dic objectForKey:@"type"]?[dic objectForKey:@"type"]:@"";
//    NSString *ID = [dic objectForKey:@"ID"]?[dic objectForKey:@"ID"]:@"";
//    
//    if ([type isEqualToString:@"delete"]) {
//        [self.selectArray addSafeObject:ID];
//    }else if([type isEqualToString:@"cancle"]) {
//        [self.selectArray removeObject:ID];
//    }
    
    self.deleteLabel.text = [NSString stringWithFormat:@"删除（%zd）",self.selectArray.count];
    [self.deleteLabel sizeToFit];
    
    if (self.selectArray.count > 0) {
        self.bottomView.backgroundColor = Theme_Color;
        self.deleteLabel.textColor = Color_White;
        
    }else {
        self.bottomView.backgroundColor = Color_Gray(223);
        self.deleteLabel.textColor = [UIColor blackColor];

    }

}

- (void)initData
{
    self.loadingType = kInit;
    self.list = [NSMutableArray array];
    //self.selectArray = [NSMutableArray array];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (self.loadingType == kLoadMore) {
        [params setSafeObject:self.wp forKey:@"wp"];
        [MyCollectionRequest getMyCollectionItemsDataWithParams:params success:^(MCItemResultModel *resultModel) {
            if (resultModel) {
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            
            [self finishLoadMore];
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishLoadMore];
            [self reloadData];
        }];
    }else{
        [MyCollectionRequest getMyCollectionItemsDataWithParams:params success:^(MCItemResultModel *resultModel) {
            [self.list removeAllObjects];
            [self hideEmptyView];
            if (resultModel) {
                
                [self.list addObjectsFromSafeArray:resultModel.list];
                self.tableView.showsInfiniteScrolling = !resultModel.isEnd;
                self.wp = resultModel.wp;
            }else{
                self.tableView.showsInfiniteScrolling = NO;
            }
            if (resultModel.list.count == 0) {
                [self showEmptyView:@"还没有收藏任何商品哦！"];
            }
            [self finishRefresh];
            [self reloadData];
            
            [self selectItem:nil];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
            [self finishRefresh];
            [self reloadData];
        }];
    }
    

}

- (NSArray*)selectArray
{
    NSMutableArray *list = [NSMutableArray array];
    for (MCItemModel *item in self.list) {
        if (item.xxSelected) {
            [list addSafeObject:item.id];
        }
    }
    return list;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.list.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        MyCollectionItemCell *cell = [MyCollectionItemCell dequeueReusableCellForTableView:tableView];
        cell.cellData = [self.list safeObjectAtIndex:row];
        cell.isEditing = self.isEditing;
        [cell reloadData];
        return cell;
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
        height = [MyCollectionItemCell heightForCell:[self.list safeObjectAtIndex:row]];
    }else{
        height = 69;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCItemModel *model = [self.list safeObjectAtIndex:indexPath.row];
    [[TTNavigationService sharedService] openUrl:model.link];
}

#pragma mark - subviews
- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-NAVBAR_HEIGHT -TabsViewHeight - 49, SCREEN_WIDTH, 49)];
        view.backgroundColor = Color_Gray(223);
        view.hidden = YES;
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteItems)]];
        _bottomView = view;
    }
    return _bottomView;
}

- (UILabel *)deleteLabel
{
    if (!_deleteLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.textColor = [UIColor blackColor];
        label.text = @"删除（0）";
        label.font = FONT(18);
        [label sizeToFit];
        label.centerX = SCREEN_WIDTH /2 ;
        label.centerY = 49/2.;
        _deleteLabel = label;
    }
    return _deleteLabel;
}

#pragma mark -deleteItems

- (void)deleteItems
{
    if (self.selectArray.count != 0) {
        NSData *data=[NSJSONSerialization dataWithJSONObject:self.selectArray options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setSafeObject:str forKey:@"items"];
        
        [MyCollectionRequest deleteCollectionItemsWithParams:params success:^{
            
            [self initData];
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    }
}

- (UIView *)emptyView
{
    if (!_emptyView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
        view.backgroundColor = [UIColor whiteColor];
        [view addSubview:self.emptyImage];
        [view addSubview:self.emptyLabel];
        _emptyView = view;
    }
    return _emptyView;
}

- (UIImageView *)emptyImage
{
    if (!_emptyImage) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 199, 217)];
        image.centerX = SCREEN_WIDTH / 2;
        image.centerY = (self.view.height - NAVBAR_HEIGHT - TabsViewHeight) /2;
        image.image = [UIImage imageNamed:@"emptyView"];
        _emptyImage = image;
    }
    return _emptyImage;
}

- (UILabel *)emptyLabel
{
    if (!_emptyLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        label.font = FONT(18);
        label.textColor = Color_Gray(140);
        label.textAlignment = NSTextAlignmentCenter;
        label.text= @"";
        label.top = self.emptyImage.bottom + 5;
        _emptyLabel = label;
        
    }
    return _emptyLabel;
}

- (void)showEmptyView:(NSString *)str
{
    [self.view addSubview:self.emptyView];
    self.emptyLabel.text = str;
}

- (void)hideEmptyView
{
    [self.emptyView removeFromSuperview];
}

@end
