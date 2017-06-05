//
//  SDLoanProcedureController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/24.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoanProcedureController.h"
#import "SDProcedureHeaderView.h"
#import "YAXSettingCell.h"
#import "SDSubmitView.h"
#import "SDNumberView.h"
#import "SDLoan.h"
#import "SDLoanProcedureBankCardController.h"
#import "SDBankCard.h"
#import "SDLoanProcedureBankCardCell.h"
#import "FDDateFormatter.h"
#import "SDAccount.h"
#import "SDLoanProtocolController.h"
#import "SDSpecialDiscountController.h"
#import "SDSpecialDiscount.h"
#import "SDSignatureAlertView.h"
#import "SDSendVerifycodeAlertView.h"
#import "SDSignatureFirstAlertView.h"
#import "SDSSQStatus.h"
#import "SDLoanSSQSignViewController.h"
#import <CoreLocation/CoreLocation.h>

#define  blueH  (440 * SCALE)
#define submitH (100 * SCALE)

@interface SDLoanProcedureController ()<UITableViewDataSource,UITableViewDelegate,SDLoanProcedureBankCardControllerDelegate,SDSpecialDiscountControllerDelegate,SignatureAlertProtocol>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) SDProcedureHeaderView *blueBackView;

@property (nonatomic, weak) SDLoanProcedureBankCardController *bcCon;

//提交按钮
@property (nonatomic, weak) SDSubmitView *submitView;

//被选中的优惠券
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *discountArray;

@end

@implementation SDLoanProcedureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FDLog(@"测试git");
    
    [self getBankCard];
    
    
    
    [self createNavBarWithTitle:@"确认借款" titleColor:[UIColor whiteColor] backImageNamed:@"icon_black_move_normal" backGroundColor:[UIColor clearColor]];
    
    [self addContent];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    
    [SDNotificationCenter addObserver:self selector:@selector(getBankCard) name:SDBankCardChangedNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(manualSign:) name:SDSSQManualNoticifation object:nil];
    //    [self getDefaultBankCard];
    [self loadDiscount];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)addContent{
    
    //顶部背景
    
    SDProcedureHeaderView *blueBackView = [[SDProcedureHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, blueH)];
    [self.view addSubview:blueBackView];
    self.blueBackView = blueBackView;
    [self addLoanTableView];
    blueBackView.loan = self.loan;
    
    //同意协议
    CGFloat labelH = 24 * SCALE;
    NSString *text = @"点击确认提交即视为同意";
    UILabel *agreeLabel = [UILabel labelWithText:text textColor:FDColor(102,102,102) font:labelH textAliment:0];
    CGFloat labelW = [text sizeOfMaxScreenSizeInFont:labelH].width;
    CGFloat labelY = blueH + 5 * 100 * SCALE + 5 * 20 * SCALE;
    agreeLabel.frame = CGRectMake(30 * SCALE, labelY, labelW, labelH);
    
    [self.view addSubview:agreeLabel];
    
    //协议按钮
    NSString *agreeString = @"《闪贷侠借款服务协议》";
    UIButton *agreeButton = [UIButton buttonWithTitle:agreeString titleColor:FDColor(55,140,244) titleFont:labelH];
    CGFloat agreeW = [agreeString sizeOfMaxScreenSizeInFont:labelH].width;
    CGFloat agreeX = CGRectGetMaxX(agreeLabel.frame);
    agreeButton.frame = CGRectMake(agreeX, labelY, agreeW, labelH);
    
    [self.view addSubview:agreeButton];
    
    [agreeButton addTarget:self action:@selector(agrreeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //提交按钮
    SDSubmitView *submitView = [[SDSubmitView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - submitH, SCREENWIDTH, submitH)];
    
    submitView.loan = self.loan;
    self.submitView = submitView;
    
    [submitView.submitButton addTarget:self action:@selector(submitButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitView];
}

- (void)agrreeButtonDidClicked{
    
    SDLoanProtocolController *web = [[SDLoanProtocolController alloc] init];
    
    web.loan = self.loan;
    web.defaultBankCard = self.defaultBankCard;
    
    
    [self.navigationController pushViewController:web animated:YES];
    
    
    
}



#pragma mark - Private
- (void)leftBtnDidTouch
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addLoanTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - blueH - submitH) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = FDColor(240, 240, 240);
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, blueH, SCREENWIDTH, SCREENHEIGHT - blueH - submitH)];
    
    
    [backView addSubview:tableView];
    
    [self.view addSubview:backView];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    YAXSettingCell *cell = [YAXSettingCell cellWithTableView:tableView];
    
    //获取数据
    cell.item = self.groups[indexPath.section][YAXItems][indexPath.row];
    
    if (indexPath.section == 0) {
        
        //创建cell
        SDLoanProcedureBankCardCell *cell = [SDLoanProcedureBankCardCell cellWithTableView:tableView];
        
        if (self.defaultBankCard) {
            
            cell.bankCard = self.defaultBankCard;
            
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.lineImageView.hidden = cell.chooseButton.hidden = YES;
        
        return cell;
        
    }
    
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            cell.contentLabel.text = @"无";
            cell.contentLabel.textColor = FDColor(255, 132, 0);
            
            if (self.specialDiscount) {
                
                cell.contentLabel.text = [NSString stringWithFormat:@"- ¥ %@",@(_specialDiscount.discountAmount)];
            }
            
        }
        
        
        
    }
    
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            self.loan.borrowFrom = [FDDateFormatter getCurrentDay];
            self.loan.borrowTo = [FDDateFormatter getNextDayWithDay:[self.loan.day integerValue] - 1];
            
            cell.contentLabel.text = self.loan.borrowTo;
            
        }
        else if (indexPath.row == 1) {
            
            cell.contentLabel.text = [NSString stringWithFormat:@"¥ %@",@(self.loan.price)];
        }
        
        else if (indexPath.row == 2) {
            
            cell.contentLabel.text = [NSString stringWithFormat:@"+ ¥%@",self.loan.charge];
            
            
            
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 120 * SCALE;
    }
    
    return 100 * SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 20 * SCALE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat height = 20 * SCALE;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    view.backgroundColor = FDColor(240, 240, 240);
    
    return view;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        FDLog(@"self.cardArray.count - %@",@(self.cardArray.count));
        
        if (self.bcCon) {
            
            [self.bcCon showWithParentController:self];
            
            
        }else{
            
            SDLoanProcedureBankCardController *bcCon = [[SDLoanProcedureBankCardController alloc] init];
            
            bcCon.cardArray = self.cardArray;
            bcCon.delegate = self;
            self.bcCon = bcCon;
            
            [bcCon showWithParentController:self];
            
        }
        
        
    }else if (indexPath.section == 1) {
        
        SDSpecialDiscountController *specialDiscount = [[SDSpecialDiscountController alloc] init];
        
        specialDiscount.loan = self.loan;
        specialDiscount.delegate = self;
        specialDiscount.selectedIndex = self.selectedIndex;
        specialDiscount.discountArray = self.discountArray;
        
        [self.navigationController pushViewController:specialDiscount animated:YES];
        
    }
    
}

#pragma mark -- SDSpecialDiscountControllerDelegate

- (void)sprcialDiscountDidClicked:(SDSpecialDiscount *)specialDiscount selectedIndex:(NSInteger)selectedIndex{
    
    self.specialDiscount = specialDiscount;
    
    self.submitView.specialDiscount = specialDiscount;
    
    self.selectedIndex = selectedIndex;
    
    [self.tableView reloadData];
    
}




- (void)getBankCard{
    
    [SDBankCard findBankCardFinishedBlock:^(id object) {
        
        [self.cardArray removeAllObjects];
        self.cardArray = object;
        [self.tableView reloadData];
        
        if(self.bcCon){
            
            self.bcCon.cardArray = object;
            [self.bcCon.tableView reloadData];
        }
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)loanProcedureBankCardDidClicked:(SDBankCard *)bankCard{
    
    self.defaultBankCard = bankCard;
    
    [self.tableView reloadData];
    
    
}


- (NSMutableArray *)cardArray{
    
    if (_cardArray == nil) {
        
        _cardArray = [NSMutableArray array];
    }
    
    return _cardArray;
}

- (void)loadDiscount{
    
    [SDSpecialDiscount specialDiscountWithLoan:self.loan finishedBlock:^(id object) {
        
        NSArray *array = object;
        if (array.count) {
            
            self.discountArray = object;
            
            self.specialDiscount = self.discountArray[0];
            
            self.submitView.specialDiscount = self.discountArray[0];
            
            [self.tableView reloadData];
            
            
        }
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)loadSSQStatus {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SDSSQStatus querySSQStatusFinishedBlock:^(id object) {
            
            switch ([object integerValue]) {
                case SSQSatusCodeManual:
                    [SDSignatureAlertView sharedSignatureAlertView].delegate = self;
                    [SDSignatureAlertView showSelected:true];
                    break;
                    
                case SSQSatusCodeAuto:
                    // TODO 自动签署 借口调用
                    [self autoSign];
                    break;
                    
                default:
                    break;
            }
        } failuredBlock:^(id object) {
            
        }];
    });
}

- (void)okButtonClick:(SSQSatusCode)ssqStatus {
    switch (ssqStatus) {
        case SSQSatusCodeManual:
            [self ssqSign];
            break;
        case SSQSatusCodeAuto:
            [self autoSign];
            break;
        default:
            break;
    }
}

//- (void)ssqSign {
//
//}

- (void)ssqSign {
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.loan.cardId = self.defaultBankCard.ID;
    [SDSSQStatus getSSQSignWithLoan:self.loan
                      finishedBlock:^(id object) {
                          [SVProgressHUD dismiss];
                          if (object == nil) {
                              return;
                          }
                          NSMutableDictionary *dataDic = object[@"data"];
                          NSNumber *codeNumber = object[@"code"];
                          
                          NSString *msg = object[@"msg"];
                          if ([[codeNumber stringValue] isEqualToString:@"1000013"]) {
                              [msg showNotice];
                          }
                          
                          if ([[codeNumber stringValue] isEqualToString:@"1000000"]) {
                              NSString *signid = dataDic[@"signid"];
                              SDLoanSSQSignViewController *controller =  [[SDLoanSSQSignViewController alloc] init];
                              //                              self.loan.cardId = self.defaultBankCard.ID;
                              controller.loan = self.loan;
                              controller.signid = signid;
                              [self.navigationController pushViewController:controller animated:YES];
                              [self commitButtonEnable:true];
                          }
                      }
                      failuredBlock:^(id object) {
                          [SVProgressHUD dismiss];
                      }];
}

// 自动签署
- (void)autoSign {
    self.loan.cardId = self.defaultBankCard.ID;
    [SDLoan updateLoan:self.loan
       specialDIscount:self.specialDiscount
                signid:@""
            isBestsign:[NSNumber numberWithInteger:0]
         finishedBlock:^(id object) {
             if ([object[@"msg"] isEqualToString:@"成功"]) {
                 [SDNotificationCenter postNotificationName:SDSubmitButtonDidClickedNitification
                                                     object:nil userInfo:@{SDLoanData:self.loan}];
                 
                 [self leftBtnDidTouch];
                 
             }
             
         }
         failuredBlock:^(id object) {
             
         }];
}

- (void)manualSign:(NSNotification *)sender {
    
    NSString *signid = [sender object];
    if (signid == nil) {
        return;
    }
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    self.loan.cardId = self.defaultBankCard.ID;
    [SDLoan updateLoan:self.loan
       specialDIscount:self.specialDiscount
                signid:signid
            isBestsign:[NSNumber numberWithInteger:1]
         finishedBlock:^(id object) {
             [SVProgressHUD dismiss];
             if ([object[@"msg"] isEqualToString:@"成功"]) {
                 [SDNotificationCenter postNotificationName:SDSubmitButtonDidClickedNitification
                                                     object:nil userInfo:@{SDLoanData:self.loan}];
                 
                 [self leftBtnDidTouch];
             }
         }
         failuredBlock:^(id object) {
             [SVProgressHUD dismiss];
             [@"网络错误" showNotice];
         }];
    
}

- (void)commitButtonEnable:(Boolean)enable {
    if (enable) {
        self.submitView.submitButton.enabled = true;
        self.submitView.submitButton.backgroundColor = FDColor(255, 214, 49);
    } else {
        self.submitView.submitButton.enabled = false;
        self.submitView.submitButton.backgroundColor = YPGrayColor;
    }
}

- (void)submitButtonDidClicked{
    
    [self commitButtonEnable:false];
    
    CLAuthorizationStatus type = [CLLocationManager authorizationStatus];
    if (![CLLocationManager locationServicesEnabled] || type == kCLAuthorizationStatusDenied){
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请开启定位服务" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            
            [[UIApplication sharedApplication] openURL:settingsURL];
            
        }];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        return;
    }
    
    //    self.loan.cardId = self.defaultBankCard.ID;
    //    [SDSSQStatus getSSQSignWithLoan:self.loan
    //                      finishedBlock:^(id object) {
    //                          NSLog(@"%@", object);
    //                      }
    //                      failuredBlock:^(id object) {
    //
    //                      }];
    
    
    //    [SDSSQStatus getSSQPreview:@"1494488324766OKUL2"
    //                 finishedBlock:^(id object) {
    //                     NSLog(@"%@", object);
    //                 } failuredBlock:^(id object) {
    //
    //                 }];
    //    [SDSSQStatus getSignPageSignimagePc:@"1494488324766OKUL2"
    //                          finishedBlock:^(id object) {
    //
    //                          } failuredBlock:^(id object) {
    //
    //                          }];
    
    [self loadSSQStatus];
    return;
    
    
    
    self.loan.cardId = self.defaultBankCard.ID;
    
    [SDLoan updateLoan:self.loan specialDisCount:self.specialDiscount finishedBlock:^(id object) {
        
        if ([object[@"msg"] isEqualToString:@"成功"]) {
            
            
            
            [SDNotificationCenter postNotificationName:SDSubmitButtonDidClickedNitification
                                                object:nil userInfo:@{SDLoanData:self.loan}];
            
            [self leftBtnDidTouch];
            
        }
        
    } failuredBlock:^(id object) {
        
        
    }];
    
    
}


@end












