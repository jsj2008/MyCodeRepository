//
//  SearchTabController.m
//  HongBao
//
//  Created by marco on 5/12/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "SearchViewController.h"

#define SearchHeaderHeight 64
#define TagCellMaxWidth    SCREEN_WIDTH/2
#define TAB_OVERLAY_WIDTH  20

@interface SearchViewController ()
@property (nonatomic, strong) UIButton *tabButton;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UILabel *searchBox;
@property (nonatomic, strong) UIButton    *cancelButton;
@property (nonatomic, strong) UIView *headerBgView;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) NSUInteger selectedIndex;


@end

@implementation SearchViewController

@synthesize tabTitle = _tabTitle;
@synthesize placeHolder = _placeHolder;

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _type = XMSearchResultTypeWall;
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _type = XMSearchResultTypeWall;
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        _type = XMSearchResultTypeWall;
    }
    return self;
}

- (void)viewDidLoad {
    self.hideNavigationBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.showsPullToRefresh = NO;
    self.tableView.showsInfiniteScrolling = NO;
//    self.collectionView.top = SearchHeaderHeight + STATUSBAR_HEIGHT;
//    self.collectionView.height = SCREEN_HEIGHT - SearchHeaderHeight;
    //self.collectionView.backgroundColor = [UIColor greenColor];

    [self.view addSubview:self.headerBgView];
    [self.view addSubview:self.tabButton];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.searchBox];
    [self.view addSubview:self.searchTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.searchTextField.text = self.key;
    [self.searchTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //清空搜索框
    //self.searchTerm = nil;
    //self.searchTextField.text = nil;
}

#pragma mark -Subviews
- (UITextField*)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(24, STATUSBAR_HEIGHT+26+2, SCREEN_WIDTH - 20 -64 -8, 28)];
        _searchTextField.font = FONT(14);
        _searchTextField.tintColor = Color_Red12;
        _searchTextField.backgroundColor = Color_White;
        _searchTextField.placeholder = @"输入您要搜索的商品";
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        [_searchTextField addTarget:self action:@selector(searchTextChanged:) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UILabel*)searchBox
{
    if (!_searchBox) {
        _searchBox = [[UILabel alloc]initWithFrame:CGRectMake(16, STATUSBAR_HEIGHT+26, SCREEN_WIDTH - 20 -64 , 32)];
        _searchBox.backgroundColor = Color_White;
        _searchBox.layer.borderColor = Color_White.CGColor;
        _searchBox.layer.borderWidth = 1.f;
        _searchBox.layer.cornerRadius = 4.f;
        _searchBox.layer.masksToBounds = YES;
    }
    return _searchBox;
}

- (UIButton*)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-56, STATUSBAR_HEIGHT+26, 44, 32)];
        [_cancelButton setTitleColor:Color_White forState:UIControlStateNormal];;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(clickback) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIView*)headerBgView
{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SearchHeaderHeight+STATUSBAR_HEIGHT)];
        _headerBgView.backgroundColor = Color_Red12;
    }
    return _headerBgView;
}

- (UIButton*)tabButton
{
    if (!_tabButton) {
        CGFloat width = (self.searchBox.width + 2*TAB_OVERLAY_WIDTH)/3;
        UIButton *tabButton = [[UIButton alloc]initWithFrame:CGRectMake(16, STATUSBAR_HEIGHT+1, width, 26)];
        [tabButton setTitleColor:Color_Gray153 forState:UIControlStateNormal];
        tabButton.titleLabel.font = FONT(14);
        [tabButton setTitle:@"商品" forState:UIControlStateNormal];
        [tabButton setBackgroundImage:[UIImage imageNamed:@"searchTab"] forState:UIControlStateNormal];
        _tabButton = tabButton;
    }
    return _tabButton;
}

- (NSString*)tabTitle
{
    if (!_tabTitle) {
        return @"商品";
    }else
        return _tabTitle;
}

- (void)setTabTitle:(NSString *)tabTitle
{
    _tabTitle  = tabTitle;
    [self.tabButton setTitle:self.tabTitle forState:UIControlStateNormal];
}


- (NSString*)placeHolder
{
    if (!_placeHolder) {
        return @"输入您要搜索的商品";
    }else{
        return _placeHolder;
    }
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder  = placeHolder;
    self.searchTextField.placeholder = self.placeHolder;
}


#pragma mark -Button action

- (void)searchTextChanged:(id)sender
{
    
    //perform search
}



- (void)clickback
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // perform search action
    NSString *kw = textField.text;
    if (kw.length > 0) {
        self.key = kw;
        NSString *link;
        if (self.type == XMSearchResultTypeWall) {
            link = [NSString stringWithFormat:@"xiaoma://searchWall?key=%@",kw];
        }else if (self.type == XMSearchResultTypeList) {
            link = [NSString stringWithFormat:@"xiaoma://searchList?key=%@",kw];
        }
        [[TTNavigationService sharedService] openUrl:link];
    }
    [textField resignFirstResponder];
    return YES;
}

@end
