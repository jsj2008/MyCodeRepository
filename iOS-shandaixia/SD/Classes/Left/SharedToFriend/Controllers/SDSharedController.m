//
//  SDSharedController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSharedController.h"
#import "SDSharedCell.h"
#import "SDSharedHeaderView.h"
#import "SDSharedView.h"
#import "SDUserInfo.h"
#import "SDLoginController.h"
#import <UShareUI/UShareUI.h>
#import "SDNetworkTool.h"
#import "SDShared.h"
#import "SDNumberView.h"


@interface SDSharedController ()<UITableViewDataSource,UITableViewDelegate,SDSharedViewDelegate>

@property (nonatomic, weak) UITableView *sharedTableView;

@property (nonatomic, weak) SDSharedHeaderView *sharedHeaderView;

//分享界面
@property (nonatomic, weak) SDSharedView *sharedView;

@property (nonatomic, strong) NSMutableArray *sharedArray;

@end

@implementation SDSharedController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"邀请好友"];
    
    
    
    //    [self addView];
    
    
    
    self.sharedArray = [NSMutableArray array];
    
//    
//    NSArray *time = @[@"2017.3.23",@"2017.3.22",@"2017.3.15",@"2017.2.23",@"2017.3.3",@"2017.3.25",@"2017.3.24",@"2017.3.12",@"2017.3.4",@"2017.3.6"];
//    
//    NSArray *account = @[@"187***7489",@"137***5589",@"153***6744",@"138***6900",@"188***3356",@"183***3255",@"185***4672",@"137***9965",@"182***5560",@"180***3350",@"135***2247",@"187***3359",@"183***5580"];
//    
//    NSArray *status = @[@"已放款",@"已还款",@"待审核",@"审核中",@"还款中"];
//    
//    for (NSInteger i = 0; i < 500; i ++) {
//        
//        
//        SDShared *shared = [[SDShared alloc] init];
//        shared.gmtCreate = time[arc4random() % (time.count)];
//        shared.phone = account[arc4random() % (account.count)];
//        shared.name = status[arc4random() % (status.count)];
//        
//        [self.sharedArray addObject:shared];
//    }
//
    
    
    [self addLoanTableView];
    
    [self loadSharedData];
    
}

- (void)loadSharedData{
    
    if (![SDUserInfo getUserInfo].ID.length) return;

    [SDShared getSharedfinishedBlock:^(id object) {
        
        [self.sharedArray addObjectsFromArray:object];
        
        [self.sharedTableView reloadData];
         
        if (self.sharedArray.count) {
            
            self.sharedHeaderView.levelView.hidden = NO;
            
            self.sharedHeaderView.numberOfManView.numberLabel.text = [NSString stringWithFormat:@"%@",@(self.sharedArray.count)];
            self.sharedHeaderView.discountMoneyView.numberLabel.text = [NSString stringWithFormat:@"¥ %@",@(self.sharedArray.count * 10)];
        }
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)addLoanTableView{
    
    UITableView *sharedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    sharedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sharedTableView = sharedTableView;
    sharedTableView.bounces = NO;
    
    sharedTableView.delegate = self;
    sharedTableView.dataSource = self;
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
//    
//    
//    [backView addSubview:sharedTableView];
    
    [self.view addSubview:sharedTableView];
    
    //顶部
    SDSharedHeaderView *sharedHeaderView = [[SDSharedHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1200 * SCALE)];
    
    self.sharedHeaderView = sharedHeaderView;
//    sharedHeaderView.height = sharedHeaderView.headerHeight;
    
    self.sharedTableView.tableHeaderView = sharedHeaderView;
    
    [sharedHeaderView.callFriendButton addTarget:self action:@selector(sharedButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];

}

- (void)sharedButtonDidClicked{
    
    
    SDUserInfo *userInfo = [SDUserInfo getUserInfo];
    
    if ([userInfo.ID isEqualToString:@""] || userInfo.ID == nil) {
        
        [self.navigationController pushViewController:[[SDLoginController alloc] init] animated:YES];
        
        
    }else{
        
        CGFloat height = 184 * SCALE;
        
        SDSharedView *sharedView = [[SDSharedView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - height, SCREENWIDTH, height)];
        
        sharedView.delegate = self;
        
        self.sharedView = sharedView;
        
        [sharedView show];
        
    }
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sharedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDSharedCell *cell = [SDSharedCell cellWithTableView:tableView];
    
    cell.shared = self.sharedArray[indexPath.row];
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 96 * SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [self.navigationController pushViewController:[[SDLoanDetailController alloc] init] animated:YES];
}


//分享协议
- (void)sharedViewSharedButtonDidClicked:(SDSharedType)sharedType{
    
    UMSocialPlatformType type;
    
    UMSocialMessageObject *massage = [[UMSocialMessageObject alloc] init];
    
    
    //创建网页内容对象
    NSString* thumbURL =  [NSString stringWithFormat:sharedImageUrl];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:sharedTitle descr:sharedContent thumImage:thumbURL];
    
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"%@/registerh5/registerInfo?userId=%@",BaseURLString,[SDUserInfo getUserInfo].ID];
    
    //图片
    //    shareObject.shareImage = [UIImage imageNamed:@"icon"];
    
    //分享消息对象设置分享内容对象
    massage.shareObject = shareObject;
    
    
    //    UMSocialPlatformType_Sina               = 0, //新浪
    //    UMSocialPlatformType_WechatSession      = 1, //微信聊天
    //    UMSocialPlatformType_WechatTimeLine     = 2,//微信朋友圈
    //    UMSocialPlatformType_WechatFavorite     = 3,//微信收藏
    //    UMSocialPlatformType_QQ                 = 4,//QQ聊天页面
    
    switch (sharedType) {
            
            /*
             
             FDSharedWeChatFriend,
             FDSharedWeChatZone,
             FDSharedSina,
             FDSharedQQFriend,
             FDSharedQQzone,
             FDSharedCopyContent
             */
            
        case SDSharedWeChatFriend:
        {
            type = UMSocialPlatformType_WechatSession;
            
        }
            break;
        case SDSharedWeChatZone:
        {
            type = UMSocialPlatformType_WechatTimeLine;
            
        }
            break;
        case SDSharedSina:
            
        {
            type = UMSocialPlatformType_Sina;
            
        }
            
            break;
        case SDSharedQQFriend:
            
        {
            type = UMSocialPlatformType_QQ;
            
            
        }
            
            break;
        case SDSharedQQzone:
        {
            
            
            
        }
            break;
        case SDSharedCopyContent:
            
            break;
            
        default:
            break;
    }
    
    //    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    //    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
    //        // 根据获取的platformType确定所选平台进行下一步操作
    //    }];
    //
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:massage currentViewController:self completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}

- (void)alertWithError:(NSError *)error
{
    [self.sharedView remove];
    
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = @"分享失败";
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享结果"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}



@end












