//
//  SDMainController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/17.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDMainController.h"
#import "YPReusableControllerConst.h"
#import "ZLScrolling.h"
#import "SDLoanView.h"
#import "SDLoginController.h"
#import "SDLoan.h"
#import "SDCheckView.h"
#import "SDRefundView.h"
#import "SDBanner.h"
#import "SDBannerController.h"
#import "SDNotice.h"
#import "SDNoticeView.h"
#import "SDLending.h"
#import "SDLendingAlertView.h"
#import "SDUserInfo.h"
#import "SDWaitRefundView.h"
#import "CBAutoScrollLabel.h"
#import "TTCollectionView.h"
#import "AFHTTPSessionManager.h"
#import "SDNetworkTool.h"
#import "SDUserVerifyDetail.h"
#import "SDNetworkTool.h"
#import "SDChangeBaseUrlView.h"
#import "SDLoanSSQSignViewController.h"
#import "SDSSQStatus.h"

#define Notice @"Notice"

@interface SDMainController ()<ZLScrollingDelegate,SDLendingAlertViewDelegate,TTCollectionViewDelegate,UIScrollViewDelegate>

//广告
@property (nonatomic,weak) ZLScrolling *adsView;

@property (nonatomic,weak) SDCheckView *checkView;

@property (nonatomic,weak) SDRefundView *refundView;

@property (nonatomic,weak) SDLoanView *loanView;

@property (nonatomic, weak) SDWaitRefundView *waitRefundView;

@property (nonatomic, strong) NSArray *bannerArray;

@property (nonatomic, strong) SDNotice *notice;

@property (nonatomic, weak) SDNoticeView *noticeView;

@property (nonatomic, strong) SDLending *lending;

@property (nonatomic, weak) TTCollectionView *adsCollectoinView;

@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;

@property (nonatomic, assign) BOOL isLoadLending;


@end

@implementation SDMainController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [SDChangeBaseUrlView show];
    
    
    self.isLoadLending = NO;
    
    [SVProgressHUD setCornerRadius:5];
        
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.65]];
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    //借款界面
    [self addLoanView];
    
    [self loadBanner];
    
    //公告
    [self addNoticeView];
    
    [self getNotice];
    
    //更新
    [self update];
        
    
    [SDNotificationCenter addObserver:self selector:@selector(submitButtonDidClicked:) name:SDSubmitButtonDidClickedNitification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(submitRefund) name:SDSubmitRefundNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loginsuccess) name:SDLoginSuccessNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(logout) name:SDLogoutNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loadLending) name:SDReceivedPushingNotification object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(updateSSQStatus:) name:SDSSQUpdateStatus object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(update) name:SDUpdateNewVersion object:nil];
    
    [SDNotificationCenter addObserver:self selector:@selector(loadBanner) name:SDNetworkReconnectNotification object:nil];
    [self checkNetwork];
}

- (void)checkNetwork {
    [GLobalRealReachability reachabilityWithBlock:^(ReachabilityStatus status) {
        switch (status) {
            case RealStatusNotReachable:
                [@"当前无网络连接" showNotice];
                break;
            default:
                break;
        }
    }];
}

- (void)logout{
   
    self.loanView.loanButton.enabled = YES;
    
    self.loanView.hidden = NO;
    self.checkView.hidden = self.refundView.hidden = self.waitRefundView.hidden = YES;
}

- (void)loginsuccess{

    [self loadLending];
}

- (void)addNoticeView{
    
    

    CGFloat height = 80 * SCALE;
    CGFloat y = SCREENHEIGHT - height - 100 * SCALE;
    SDNoticeView *noticeView = [[SDNoticeView alloc] initWithFrame:CGRectMake(0, y, SCREENWIDTH, height)];
    [self.view addSubview:noticeView];
    noticeView.hidden = YES;
    self.noticeView = noticeView;
    
    [noticeView.noticeButton addTarget:self action:@selector(noticeButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)noticeButtonDidClicked{
    
    [FDUserDefaults setObject:self.notice.ID forKey:Notice];

    [UIView animateWithDuration:0.25 animations:^{
       
        self.noticeView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [self.noticeView removeFromSuperview];
    }];
}

- (void)getNotice{
    
    NSString *notice = [FDUserDefaults objectForKey:Notice];
    
    

    [SDNotice noticeFinishedBlock:^(id object) {
        
        
        self.notice = object;
        
        if (self.notice.content.length) {
        
            if (![self.notice.ID isEqualToString:notice]) {
                
                self.noticeView.hidden = NO;
                
                self.noticeView.autoScrollLabel.text = self.notice.content;

            }
            
        }
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)submitButtonDidClicked:(NSNotification *)note{

    
//    SDLoan *loan = note.userInfo[SDLoanData];
    self.loanView.hidden = YES;
    self.checkView.hidden = NO;

    [self loadLending];
    
}

- (void)reloadBanner {
    [self.adsCollectoinView removeFromSuperview];
    [self loadBanner];
}

- (void)loadBanner{

    [SDBanner bannerFinishedBlock:^(id object) {
        
        self.bannerArray = object;
        
        if (self.bannerArray.count) {
            //添加广告
            [self addAds];
        } else {
            [self addLoadAddFailed];
        }
        
        
    } failuredBlock:^(id object) {
        [self addLoadAddFailed];
    }];
    
    
    
}

- (void)dealloc{

    [SDNotificationCenter removeObserver:self];
    
}

#pragma make - 添加滚动广告
- (void)addAds{
    
    NSMutableArray *imageUrlArray = [NSMutableArray array];
    
    
    for (SDBanner *banner in self.bannerArray) {
        
        
        
        NSURL *url = [[NSURL alloc] initWithString:banner.imgUrl];
        [imageUrlArray addObject:url];
    }
    
    
    TTCollectionView *adsCollectoinView = [[TTCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, ADSHEIGHT)];
    // 这里设置轮播图的自动播放时间间隔
    self.adsCollectoinView = adsCollectoinView;
    adsCollectoinView.timeInterval = 4.0;
    // 这里直接传图片的URL字符串(切记是字符串), 要不你还要改里面的图片赋值语句
    adsCollectoinView.imagesArr = imageUrlArray.copy;
    [self.view addSubview:adsCollectoinView];
    // 此属性一定要在collectionView添加到俯视图之后再设置, 这里是图片的数量
    adsCollectoinView.imagesCount = imageUrlArray.count;
    // 设置代理(主要用来解决点击图片的事件)
    adsCollectoinView.collectionViewDelegate = self;
    
}

- (void)addLoadAddFailed {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, ADSHEIGHT)];
    [imageView setImage:[UIImage imageNamed:@"icon_unselected"]];
    [self.view addSubview:imageView];
}

#pragma mark - 这里实现cell的点击事件(根据index(也就是indexPath.item))
- (void)cellClickWithIndex:(NSInteger)index {
    
    SDBanner *banner = self.bannerArray[index];
    
    if (banner.httpUrl.length) {
        
        SDBannerController *webCon = [[SDBannerController alloc] init];
        
        webCon.banner = banner;
        
        [self.navigationController pushViewController:webCon animated:YES];
    }
    
    

}

- (void)addLoanView{
    
    CGFloat height = SCREENHEIGHT - ADSHEIGHT;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ADSHEIGHT, SCREENWIDTH, height)];
    self.scrollview = scrollView;
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(0, SCREENHEIGHT);
    scrollView.backgroundColor = FDColor(243, 245, 249);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.center = CGPointMake(SCREENWIDTH/2, - 40);
    [scrollView addSubview:indicator];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.indicator = indicator;
    [indicator startAnimating];
    
    //借款
    SDLoanView *loanView = [[SDLoanView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    [scrollView addSubview:loanView];
    self.loanButton = loanView.loanButton;
//    loanView.hidden = YES;
    self.loanView = loanView;
    
    //审核
    SDCheckView *checkView = [[SDCheckView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    self.checkView = checkView;
    [scrollView addSubview:checkView];
    checkView.hidden = YES;
    
    //还款
    SDRefundView *refundView = [[SDRefundView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    self.refundView = refundView;
    refundView.hidden = YES;
    self.refundButton = refundView.refundButton;
    [scrollView addSubview:refundView];
    
    [refundView.refundButton addTarget:self action:@selector(refundButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //等待结果
    SDWaitRefundView *waitRefundView = [[SDWaitRefundView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
    self.waitRefundView = waitRefundView;
    waitRefundView.hidden = YES;
    [scrollView addSubview:waitRefundView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    CGFloat y = scrollView.contentOffset.y;
    
    if (y > 0) {
        
        scrollView.contentOffset = CGPointMake(0, 0);
        
    }else if (y < -50){
        
        if (!self.isLoadLending) {
            
            
            [self loadLending];
            
            if ([self.delegate respondsToSelector:@selector(mainControllerScrollDelegate)]) {
                
                [self.delegate mainControllerScrollDelegate];
            }
        }
    }
}


- (void)submitRefund{

    [self loadLending];
    
}

- (void)refundButtonDidClicked{


    [SDNotificationCenter postNotificationName:SDRefundButtonDidClickedNitification object:nil userInfo:@{SDLendingData:self.lending}];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.adsCollectoinView addTimer];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    
    [self.adsCollectoinView removeTimer];
    
}

- (void)loadLending{
    
    if (![SDUserInfo getUserInfo].ID.length) return;
    
    NSLog(@"loadLending -------- ");
    
    self.isLoadLending = YES;
 
    [SDLending lendingFinishedBlock:^(id object) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.isLoadLending = NO;
        });
        
        [SVProgressHUD dismiss];
        
        
        self.lending = object;
        
        if (!object) {
            
            
        }
        
        FDLog(@"status - %@",@(self.lending.status));
        
        if (self.lending.orderId.length) {
            
            self.lending = object;
            self.checkView.lending = self.lending;
            self.refundView.lending = self.lending;
            SDLendingAlertView *alert = [SDLendingAlertView sharedLendingAlertView];
            alert.lending = self.lending;
            alert.delegate = self;
            
            /*
             SDLendingStatusPreCheck,
             SDLendingStatusChecking,
             SDLendingStatusCheckFailed,
             SDLendingStatusWaitMoney,
             SDLendingStatusLendFailed,
             SDLendingStatusLendSuccess,
             SDLendingStatusWaitRefund,
             SDLendingStatusOverdue
             */
            
            switch (self.lending.status) {
                case SDLendingStatusPreCheck:
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    break;
                case SDLendingStatusChecking:
                    
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    
                    break;
                case SDLendingStatusCheckFailed:
                    
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    
                    [SDLendingAlertView show];
                    break;
                case SDLendingStatusWaitMoney:
                    
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    
                    break;
                case SDLendingStatusLendFailed:
                    
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    
//                    [SDLendingAlertView show];
                    break;
                case SDLendingStatusLoaning:
                    
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    
                    //                    [SDLendingAlertView show];
                    break;
                case SDLendingStatusLendSuccess:
                    
                    self.checkView.hidden = NO;
                    self.loanView.hidden = self.refundView.hidden = YES;
                    
                    [SDLendingAlertView show];
                    
                    break;
                case SDLendingStatusWaitRefund:
                    
                    self.refundView.hidden = NO;
                    self.loanView.hidden = self.checkView.hidden = YES;
                    
                    break;
                    
                case SDLendingStatusOverdue:
                    
                    self.refundView.hidden = NO;
                    self.loanView.hidden = self.checkView.hidden = YES;
                    
                    break;
                case SDLendingStatusRefundSuccess:
                    
                    [@"还款成功" showNotice];
                    
                    self.loanView.hidden = NO;
                    self.refundView.hidden = self.checkView.hidden = YES;
                    
                    break;
                case SDLendingStatusRefunding:
                    
                    self.refundView.hidden = NO;
                    self.loanView.hidden = self.checkView.hidden = YES;
                    
                    break;
                    
                default:
                    break;
            }
            
        }else{
        
            self.loanView.hidden = NO;
            self.refundView.hidden = self.checkView.hidden = YES;
            
            return;
        }
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.isLoadLending = NO;
        });
        
    }];
}

- (void)lendingAlertViewKnowButtonDidClicked:(SDLending *)lending{

    if (lending.status == SDLendingStatusCheckFailed || lending.status == SDLendingStatusLendSuccess) {
        
        if (lending.status == SDLendingStatusLendSuccess) {
            
            lending.status = SDLendingStatusWaitRefund;
        }
        
        [SDLending updateLendingStatus:lending finishedBlock:^(id object) {
            
            
        } failuredBlock:^(id object) {
            
        }];
        
        if (lending.status == SDLendingStatusCheckFailed) {
            
            self.checkView.hidden = YES;
            self.loanView.hidden = NO;
        }else{
        
            self.checkView.hidden = YES;
            self.refundView.hidden = NO;
        }
    }
    
    
    
}


- (void)update{
    
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *oldVersion = infoDict[@"CFBundleShortVersionString"];
    
    NSString *appId = [(NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"App Store Application Id"] copy];
    
    
    
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appId];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript", nil];
    
    [manager POST:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        
        
        NSNumber *number = responseObject[@"resultCount"];
        
        
        
        if (number.intValue == 1) {
            
            NSString *newVersion = responseObject[@"results"][0][@"version"];
            
            if ([newVersion isEqualToString:@"1.0.0"]) return;
            
            [FDUserDefaults setObject:oldVersion forKey:FDVersion];
            [FDUserDefaults setObject:newVersion forKey:FDNewVersion];
            [FDUserDefaults synchronize];
            
//            FDLog(@"new - %@,old - %@",@([newVersion floatValue]),@([oldVersion floatValue]));
//            
//            FDLog(@"[newVersion compare:oldVersion] - %@",@([newVersion compare:oldVersion]));
            
            if ([newVersion compare:oldVersion] == NSOrderedDescending) {
            
                
                [self forceUpgrade];
            }
        
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
    
}

- (void)forceUpgrade{

    NSString *appId = [(NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"App Store Application Id"] copy];
    
    NSDictionary *dict = @{@"clientType":@"2"
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/version/queryNewVersion";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        NSString *newVersion = dict[@"version"];
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        
        NSString *oldVersion = infoDict[@"CFBundleShortVersionString"];

        if ([newVersion compare:oldVersion] == NSOrderedDescending) {
            FDLog(@"dict - %@",dict);
            
            NSNumber *forced = dict[@"hasForcedUpgrade"];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@?mt=8",appId]]];
                
            }];
            
            if ([forced isEqual:@(2)]) {
                
                UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                
                [alertController addAction:cancleAction];
                
                
            }
            
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        
    }];
    
}

- (void)setUserVerifyDetail:(SDUserVerifyDetail *)userVerifyDetail{

    _userVerifyDetail = userVerifyDetail;
    
    FDLog(@"userVerifyDetail.operatorStatus - %@",_userVerifyDetail.operatorStatus);
    
    
    if ([self.userVerifyDetail.operatorStatus isEqual:@(2)]){
        
        [self.loanView.loanButton setTitle:@"  运营商认证中" forState:UIControlStateDisabled];
        
        self.loanView.loanButton.enabled = NO;
    }else{
    
        self.loanView.loanButton.enabled = YES;
    }
    
}


#pragma mark - update status

- (void)updateSSQStatus:(NSNotification *)notification {
    NSNumber *status = [notification object];
    [SDSSQStatus modifySSQStatusIsBestsign:status
                             finishedBlock:^(id object) {
                                 [SDNotificationCenter postNotificationName:SDSSQqueryStatus
                                                                     object:nil];
                                 
                             } failuredBlock:^(id object) {
                                 [@"修改失败" showNotice];
                             }];
}

@end











