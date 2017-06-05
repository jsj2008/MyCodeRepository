//
//  SDBankCardController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/23.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDBankCardController.h"
#import "SDBankCard.h"
#import "YAXSettingCell.h"
#import "SDAddBankCardController.h"
#import "SDBankCardCell.h"
#import "SDBankCardDetailController.h"

@interface SDBankCardController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIButton *addBankCardButton;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cardArray;

@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIView *noBankCardView;

@end

@implementation SDBankCardController

- (NSMutableArray *)cardArray{

    if (_cardArray == nil) {
        
        _cardArray = [NSMutableArray array];
    }
    
    return _cardArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavBarWithTitle:@"银行卡"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self addEditButton];
    [self addLoanTableView];
    
    [self addNoBankCardView];
    
    [self getBankCard];
    
    [SDNotificationCenter addObserver:self selector:@selector(getBankCard) name:SDBankCardChangedNotification object:nil];
    
    
    
}


- (void)getBankCard{

    [SVProgressHUD show];
    
    [SDBankCard findBankCardFinishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        [self.cardArray removeAllObjects];
        self.cardArray = object;
        [self.tableView reloadData];
        
        if (self.cardArray.count) {
            
            self.noBankCardView.hidden = YES;
        }else{
        
            
            self.noBankCardView.hidden = NO;
        }
        
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
    }];
}

- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = self.view.backgroundColor = FDColor(243, 245, 249);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    self.backView = backView;
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}


- (void)addEditButton{

    // 左侧按钮(固定)
    UIButton *editButton = [UIButton buttonWithTitle:@"添加" titleColor:FDColor(34, 34, 34) titleFont:14];
    [self.navBarContainer addSubview:editButton];
    [editButton setTitleColor:FDColor(70, 151, 251) forState:UIControlStateSelected];
    editButton.frame = CGRectMake(SCREENWIDTH - 44, 23, 44, 44);
    [editButton addTarget:self action:@selector(editButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editButtonDidClicked:(UIButton *)button{
    
    SDAddBankCardController *add =  [[SDAddBankCardController alloc] init];
    
    add.userCenter = self.userCenter;
    
    [self.navigationController pushViewController:add animated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.cardArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    SDBankCardCell *cell = [SDBankCardCell cellWithTableView:tableView];
    
    cell.bankCard = self.cardArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 228 * SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDBankCardDetailController *bankDetailCon = [[SDBankCardDetailController alloc] init];
    bankDetailCon.bankCard = self.cardArray[indexPath.row];
        
    [self.navigationController pushViewController:bankDetailCon animated:YES];

    
}

- (void)dealloc{

    [SDNotificationCenter removeObserver:self];
}

- (void)addNoBankCardView{

    UIView *noBankCardView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    noBankCardView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:noBankCardView];
    self.noBankCardView = noBankCardView;
    noBankCardView.hidden = YES;
    
    UIImageView *noBankImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big_icon_card"]];
    [noBankImageView sizeToFit];
    
    noBankImageView.centerX = SCREENWIDTH/2;
    noBankImageView.y = 200 * SCALE;
    [noBankCardView addSubview:noBankImageView];
    
    UILabel *nobankCardLabel = [UILabel labelWithText:@"你未添加银行卡" textColor:FDColor(34,34,34) font:34 * SCALE textAliment:1];
    nobankCardLabel.frame = CGRectMake(0, CGRectGetMaxY(noBankImageView.frame) + 20 * SCALE, SCREENWIDTH, 34 * SCALE);
    [noBankCardView addSubview:nobankCardLabel];
    
    UIView *buttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nobankCardLabel.frame) + 100 * SCALE, SCREENWIDTH, 100 * SCALE)];
    
    buttonBackView.backgroundColor = SDWhiteColor;
    [noBankCardView addSubview:buttonBackView];
    
    CGFloat buttonW = [@"添加银行卡" sizeOfMaxScreenSizeInFont:30 * SCALE].width;
    
    UIButton *addBankCardButton = [UIButton buttonWithTitle:@"添加银行卡" titleColor:FDColor(70, 151, 251) titleFont:30 * SCALE imageNamed:nil];
    addBankCardButton.frame = CGRectMake((SCREENWIDTH - buttonW)/2, 25 * SCALE, buttonW, 50 * SCALE);
    [buttonBackView addSubview:addBankCardButton];
    
    
    [addBankCardButton addTarget:self action:@selector(editButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *addImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_add_normal"]];
    
    [addImageView sizeToFit];
    addImageView.centerY = 50 * SCALE;
    addImageView.x = addBankCardButton.x - 10 * SCALE - addImageView.width;
    [buttonBackView addSubview:addImageView];
    
}



@end


