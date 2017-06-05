//
//  SDLoanProcedureBankCardController.m
//  SD
//
//  Created by 余艾星 on 17/3/7.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDLoanProcedureBankCardController.h"
#import "SDBankCard.h"
#import "SDLoanProcedureBankCardCell.h"
#import "SDAddBankCardController.h"
#import "SDLoanProcedureController.h"

@interface SDLoanProcedureBankCardController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIButton *shadowButton;


@property (nonatomic, weak) SDLoanProcedureController *parentController;


@end

@implementation SDLoanProcedureBankCardController

- (NSMutableArray *)cardArray{
    
    if (_cardArray == nil) {
        
        _cardArray = [NSMutableArray array];
    }
    
    return _cardArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNavBarWithTitle:@"选择银行卡" titleColor:FDColor(34, 34, 34) backImageNamed:@"icon_call-off" backGroundColor:SDWhiteColor];
    
    // bottomLine
    UIView *bottomLine = [[UIView alloc] init];
    [self.navBarContainer addSubview:bottomLine];
    bottomLine.backgroundColor = FDColor(220, 220, 220);
    bottomLine.frame = CGRectMake(0, self.navBarContainer.yp_height - 0.5, self.navBarContainer.yp_width, 0.5);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addLoanTableView];
    
    [self getBankCard];
    
    [SDNotificationCenter addObserver:self selector:@selector(getBankCard) name:SDUnbindBackCardSuccessNotification object:nil];
    
    
}

- (void)dealloc{
    
    [SDNotificationCenter removeObserver:self];
}

- (void)leftBtnDidTouch{

    
    [self dissmiss];
}


- (void)showWithParentController:(SDLoanProcedureController *)controller{

    
    self.parentController = controller;
    
    [controller addChildViewController:self];
    
    UIButton *shadowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.shadowButton = shadowButton;
    [shadowButton addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    [controller.view addSubview:shadowButton];
    shadowButton.backgroundColor = [UIColor blackColor];
    shadowButton.alpha = 0.6;
    self.view.height = 829 * SCALE;
    self.view.y = SCREENHEIGHT;
    
    [self.parentController.view addSubview:self.view];
    
    
    [UIView animateWithDuration:0.35 animations:^{
       
        self.view.y = SCREENHEIGHT - self.view.height;
    }];
    
}

- (void)dissmiss{
    
    [UIView animateWithDuration:0.35 animations:^{
       
        self.view.y = SCREENHEIGHT;
    } completion:^(BOOL finished) {
        
        [self.shadowButton removeFromSuperview];
        [self.view removeFromSuperview];
    }];

    
}


- (void)getBankCard{
    
    [SDBankCard findBankCardFinishedBlock:^(id object) {
        
        [self.cardArray removeAllObjects];
        self.cardArray = object;
        [self.tableView reloadData];
    } failuredBlock:^(id object) {
        
    }];
}

- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 829 * SCALE - 64) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = self.view.backgroundColor = FDColor(243, 245, 249);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 829 * SCALE - 64)];
    self.backView = backView;
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}



- (void)editButtonDidClicked:(UIButton *)button{
    
    [self.navigationController pushViewController:[[SDAddBankCardController alloc] init] animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.cardArray.count;
    }else{
        
        return 1;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    if (indexPath.section == 0) {
        
        //创建cell
        SDLoanProcedureBankCardCell *cell = [SDLoanProcedureBankCardCell cellWithTableView:tableView];
        
        cell.bankCard = self.cardArray[indexPath.row];
        
        return cell;
        
    }else{
    
        static NSString *ID = @"SDLoanProcedureBankCardCell2";
        SDLoanProcedureBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            
            
            cell = [[SDLoanProcedureBankCardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            
            cell.backgroundColor = SDWhiteColor;
            //
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:SDWhiteColor]];
        }
        
        cell.bankIconImageView.image = [UIImage imageNamed:@"icon_small_card"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *label = [UILabel labelWithText:@"添加银行卡" textColor:FDColor(34,34,34) font:30 * SCALE textAliment:0];
        label.frame = CGRectMake(134 * SCALE, 0, 200, 30 * SCALE);
        label.centerY = 65 * SCALE;
        [cell.contentView addSubview:label];
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130 * SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        [self.parentController.navigationController pushViewController:[[SDAddBankCardController alloc] init] animated:YES];
        
    }else{
    
        if ([self.delegate respondsToSelector:@selector(loanProcedureBankCardDidClicked:)]) {
            
            [self.cardArray enumerateObjectsUsingBlock:^(SDBankCard *bankCard, NSUInteger idx, BOOL * _Nonnull stop) {
                
                bankCard.isDefault = NO;
                self.cardArray[idx] = bankCard;
                
            }];
            
            SDBankCard *bankCard = self.cardArray[indexPath.row];
            bankCard.isDefault = YES;
            
            self.cardArray[indexPath.row] = bankCard;
            
            [self.tableView reloadData];
            
            [self.delegate loanProcedureBankCardDidClicked:bankCard];
            
            [self dissmiss];
        }
    }
    
}



@end
