//
//  SDLoanDetailController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/20.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDLoanDetailController.h"
#import "SDLoanDetailView.h"
#import "SDMyLoan.h"
#import "SDMyLoanDetail.h"
#import "SDLoanProtocolController.h"
#import "SDSSQProtocolController.h"

@interface SDLoanDetailController ()

@property (nonatomic, strong) SDMyLoanDetail *myLoanDetail;

@property (nonatomic, weak) SDLoanDetailView *loadDetailView;

@property (nonatomic, weak) UIButton *showLoanProtocolButton;

@end

@implementation SDLoanDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = FDColor(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"我的借款"];
    
    [self addContent];
    
}

- (void)addContent{
    
    SDLoanDetailView *loadDetailView = [[SDLoanDetailView alloc] init];
    self.loadDetailView = loadDetailView;
    loadDetailView.frame = CGRectMake(0, 64 + 20 * SCALE, SCREENWIDTH, 772 * SCALE);
    
    [self.view addSubview:loadDetailView];
    
    
    UIButton *showLoanProtocolButton = [UIButton buttonWithTitle:@"查看《闪贷侠借款协议》"
                                                      titleColor:SDBlackColor
                                                       titleFont:30 * SCALE];
    showLoanProtocolButton.backgroundColor = SDWhiteColor;
    showLoanProtocolButton.frame = CGRectMake(0, 64 + 808 * SCALE, SCREENWIDTH, 100 * SCALE);
    [showLoanProtocolButton addTarget:self
                               action:@selector(showLoanProtocol)
                     forControlEvents:UIControlEventTouchUpInside];
    self.showLoanProtocolButton = showLoanProtocolButton;
    [self.view addSubview:showLoanProtocolButton];
    
    switch ([_myLoan.status integerValue]) {
        case -1:
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
            self.showLoanProtocolButton.hidden = YES;
            break;
        case 5:
        case 6:
        case 7:
        case 8:
        case 10:
            self.showLoanProtocolButton.hidden = NO;
            break;
            
        default:
            break;
    }
    
}

- (void)showLoanProtocol {
    //    SDLoanProtocolController *web = [[SDLoanProtocolController alloc] init];
    
    //    web.loan = _myLoan;
    //    web.defaultBankCard = self.defaultBankCard;
    
    
    //    [self.navigationController pushViewController:web animated:YES];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [SDMyLoanDetail getMyProtocolOrderId:_myLoan.ID
                     detailfinishedBlock:^(id object) {
                         [SVProgressHUD dismiss];
                         NSDictionary *dict = object[@"data"];
                         NSString *url = dict[@"contractUrl"];
                         NSNumber *code = object[@"code"];
                         if ([code isEqualToNumber:[NSNumber numberWithLong:1000000]]) {
                             if (object != nil) {
                                 SDSSQProtocolController *ssqProController = [[SDSSQProtocolController alloc] init];
                                 ssqProController.url = url;
                                 [self.navigationController pushViewController:ssqProController animated:YES];
                             }
                         } else {
                             [object[@"msg"] showNotice];
                         }
                         
                     } failuredBlock:^(id object) {
                         [SVProgressHUD dismiss];
                         [@"查询失败" showNotice];
                     }];
}

- (void)setMyLoan:(SDMyLoan *)myLoan{
    
    _myLoan = myLoan;
    
    
    [SVProgressHUD show];
    [SDMyLoanDetail getMyLoanOrderId:myLoan.ID detailfinishedBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        self.loadDetailView.myLoanDetail = object;
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
    }];
}

@end
