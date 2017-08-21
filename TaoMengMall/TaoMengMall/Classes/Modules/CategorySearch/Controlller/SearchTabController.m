//
//  SearchTabController.m
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "SearchTabController.h"
#import "SearchViewController.h"
#import "SearchRequest.h"

#import "TagItemCell.h"
#import "SearchHeaderView.h"
#import "SearchFooterView.h"


#define SearchHeaderHeight 64
#define TagCellMaxWidth    SCREEN_WIDTH/2
#define TAB_OVERLAY_WIDTH  20

@interface SearchTabController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UILabel *searchBox;
@property (nonatomic, strong) UIButton    *cancelButton;
@property (nonatomic, strong) UIView *headerBgView;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableArray *tabs;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) NSUInteger selectedIndex;

//@property (nonatomic, strong) NSMutableArray *histories;
@property (nonatomic, strong) NSArray *hotWords;
@property (nonatomic, strong) NSMutableArray *results;

@property (nonatomic, assign) XMSearchResultType type;

@end

@implementation SearchTabController

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedIndex = 0;
        //self.histories = [NSMutableArray arrayWithArray:@[@"ddd",@"ddd",@"dd",@"fjfkkf",@"u盘",@"韩后",@"藕片 奶茶",@"单鞋"]];
        //self.hotWords = @[@"ddd",@"ddd",@"dd",@"fjfkkf",@"u盘",@"韩后",@"藕片",@"单鞋"];
        //self.results = [NSMutableArray arrayWithArray:@[@"ddd",@"ddd",@"dd",@"fjfkkf",@"u盘",@"韩后",@"藕片 奶茶",@"单鞋"]];

        //self.titles = @[@"ddd",@"ddd",@"dd"];

    }
    return self;
}

- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.showsPullToRefresh = NO;
    self.collectionView.showsInfiniteScrolling = NO;
    self.collectionView.top = NAVBAR_HEIGHT;
    self.collectionView.height = SCREEN_HEIGHT - NAVBAR_HEIGHT;
    self.tabs = [NSMutableArray arrayWithCapacity:self.self.titles.count];

    [self.view addSubview:self.headerBgView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.searchTextField];
    [self.view addSubview:self.line];
    
    self.type = XMSearchResultTypeWall;

    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.searchTextField.text = self.key;
    [self.searchTextField becomeFirstResponder];
}

- (void)initData
{
    self.loadingType = kInit;
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [SearchRequest getHotTagsWithParams:params success:^(NSArray *resultModel) {
        self.hotWords = resultModel;
        [self finishRefresh];
        [self reloadData];
    } failure:^(StatusModel *status) {
        [self showNotice:status.msg];
        [self finishRefresh];
        [self reloadData];
    }];
}

#pragma mark -Subviews
- (UITextField*)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(12, STATUSBAR_HEIGHT+7, SCREEN_WIDTH - 12 - 56, 30)];
        _searchTextField.font = FONT(14);
        _searchTextField.placeholder = @"搜索商品";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.backgroundColor = Color_Gray240;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.layer.cornerRadius = 2.;
        _searchTextField.layer.masksToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        imageView.image = [UIImage imageNamed:@"search_icon_search"];
        imageView.centerY = 15;
        imageView.centerX = 15;
        UIView *bkg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [bkg addSubview:imageView];
        _searchTextField.leftView = bkg;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        [_searchTextField addTarget:self action:@selector(searchTextChanged:) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UIButton*)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, STATUSBAR_HEIGHT+7, 44, 30)];
        [_cancelButton setTitleColor:Color_Gray(165) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = FONT(16);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIView*)headerBgView
{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NAVBAR_HEIGHT)];
        _headerBgView.backgroundColor = [UIColor whiteColor];
    }
    return _headerBgView;
}

- (UIView*)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 1)];
        view.backgroundColor = Color_Gray238;
        _line = view;
    }
    return _line;
}

- (void)addCollectionView
{
    EquidistantLayout *layout = [[EquidistantLayout alloc] init];
    layout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.hideNavigationBar ? 0 : NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (self.hideNavigationBar ? 0 : NAVBAR_HEIGHT)) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self registCell];
    
    [self.view addSubview:self.collectionView];

}

- (void)registCell
{
    [self.collectionView registerClass:[TagItemCell class] forCellWithReuseIdentifier:[TagItemCell cellIdentifier]];
    [self.collectionView registerClass:[SearchHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchHeaderView identifier]];
    //[self.collectionView registerClass:[SearchFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[SearchFooterView identifier]];
}


- (void)searchTextChanged:(id)sender
{
    
    //perform search
}

- (void)deleteBtnClick:(id)sender
{
    //[self.histories removeAllObjects];
    [self reloadData];
}

- (void)clickback
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark -UICollectionView DataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.selectedIndex == 0) {
        return 1;
    }else
        return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if ((self.selectedIndex == 0)&&
        (self.searchTextField.text.length == 0)) {
        if (section == 0) {
            count = [self.hotWords count];
        }
    }else{
        count= [self.results count];
    }
    return count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    switch (self.selectedIndex) {
        case 0:
        {
            if (self.searchTextField.text.length == 0) {
                TagItemCell *tagCell = (TagItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[TagItemCell cellIdentifier] forIndexPath:indexPath];
                if (indexPath.section == 0) {
                    tagCell.title = [self.hotWords objectAtIndex:indexPath.row];
                }
                cell.backgroundColor = [UIColor redColor];
                cell = tagCell;
            }else{
                
            }
        }
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
     UICollectionReusableView *reusableview = nil;
    if ((self.selectedIndex == 0)&&
        self.searchTextField.text.length == 0) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
            SearchHeaderView *view = (SearchHeaderView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SearchHeaderView identifier] forIndexPath:indexPath];
            if (indexPath.section==0)
            {
                view.actionButton.hidden=NO;
                [view.actionButton setImage:[UIImage imageNamed:@"icon_V2"] forState:UIControlStateNormal];
                [view.actionButton addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                view.titleLabel.text=@"热门搜索";
                //view.titleLabel.textColor=[UIColor colorWithType:@"Ea"];
                //view.imgView.image=[UIImage imageNamed:@"ic_lsjl"];
            }
            else
            {
                view.actionButton.hidden=YES;
                view.titleLabel.text=@"历史搜索";
                //view.titleLabel.textColor=[UIColor colorWithType:@"tyEb1"];
                //view.imgView.image=[UIImage imageNamed:@"ic_rmss"];
            }
            reusableview = view;
        }
//        if ([kind isEqualToString: UICollectionElementKindSectionFooter]) {
//            SearchFooterView *view = (SearchFooterView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[SearchFooterView identifier] forIndexPath:indexPath];
//            if (indexPath.section == 0) {
//                view.separatorView.hidden = NO;
//                view.titleLabel.hidden = NO;
//                reusableview = view;
//            }else{
//                view.separatorView.hidden = YES;
//                view.titleLabel.hidden = YES;
//                reusableview = view;
//            }
//        }
        
    }
    return reusableview;
}
#pragma mark --EquidistantLayoutDelegate

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.selectedIndex) {
        case 0:
        {
            if (self.searchTextField.text.length == 0) {
                CGFloat width = 0;
                if (indexPath.section == 0) {
                    width = [[self.hotWords objectAtIndex:indexPath.row] sizeWithUIFont:[UIFont systemFontOfSize:14] forWidth:TagCellMaxWidth].width;
                }
                width += 20;
                return CGSizeMake(width, 30);
            }
        }
            break;
            
        default:
            break;
    }
    return CGSizeMake(20, 20);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 32);
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(self.view.bounds.size.width, 1);
//}

//定义每个UICollectionView 的 margin
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout itemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 12, 10, 12);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *kw = [self.hotWords safeObjectAtIndex:indexPath.item];
    NSString *link;
    if ([self.searchType isEqualToString:@"pointSearch"]) {
        link = [NSString stringWithFormat:@"xiaoma://pointMallSearch?key=%@&cateId=%@",self.key,self.cateId];;
    }
    else if (self.type == XMSearchResultTypeWall) {
        link = [NSString stringWithFormat:@"xiaoma://searchWall?key=%@&shopId=%@",kw,self.shopId];
    }else if (self.type == XMSearchResultTypeList) {
        link = [NSString stringWithFormat:@"xiaoma://searchList?key=%@&shopId=%@",kw,self.shopId];
    }
    [[TTNavigationService sharedService] openUrl:link];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // perform search action
    NSString *kw = textField.text;
    if (kw.length > 0) {
        self.key = kw;
        NSString *link;
        if ([self.searchType isEqualToString:@"pointSearch"]) {
            link = [NSString stringWithFormat:@"xiaoma://pointMallSearch?key=%@&cateId=%@",self.key,self.cateId];;
        }else if (self.type == XMSearchResultTypeWall) {
            link = [NSString stringWithFormat:@"xiaoma://searchWall?key=%@&shopId=%@",kw,self.shopId];
        }else if (self.type == XMSearchResultTypeList) {
            link = [NSString stringWithFormat:@"xiaoma://searchList?key=%@&shopId=%@",kw,self.shopId];
        }
        [[TTNavigationService sharedService] openUrl:link];
    }
    [textField resignFirstResponder];
    return YES;
}
@end
