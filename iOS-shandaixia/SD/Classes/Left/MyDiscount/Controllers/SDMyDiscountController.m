//
//  SDMyDiscountController.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/19.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDMyDiscountController.h"
#import "SDDiscountCell.h"
#import "SDSharedView.h"
#import "SDDiscount.h"
#import "SDLoginButton.h"
#import <UShareUI/UShareUI.h>
#import "SDUserInfo.h"

@interface SDMyDiscountController ()<UITableViewDataSource,UITableViewDelegate,SDSharedViewDelegate>

@property (nonatomic, weak) UITableView *discountTableView;

//分享界面
@property (nonatomic, weak) SDSharedView *sharedView;

@property (nonatomic, strong) NSArray *discountArray;


@end

@implementation SDMyDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = FDColor(240, 240, 240);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"优惠券"];
    
    //    [self addView];
    
    [self addLoanTableView];
    
    [self addRightButton];
    
    [self loadDiscount];
    
}

- (void)loadDiscount{

    [SVProgressHUD show];
    
    [SDDiscount discountWithType:self.discountType finishedBlock:^(id object) {
       
        [SVProgressHUD dismiss];
        
        NSArray *array = object;
        if (array.count) {
            
            self.discountArray = object;
            
            if ([self.discountType isEqualToString:@"1"]) {
                
//                [self addHistoryDiscountButton];
                self.discountTableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
            }
            
            
            [self.discountTableView reloadData];
            
        }else{
        
            [self noContentUIWithImageNamed:@"no_discount"];
        }
        
        
    } failuredBlock:^(id object) {
        
        [SVProgressHUD dismiss];
    }];
}

- (void)addLoanTableView{
    
    UITableView *discountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64) style:UITableViewStylePlain];
    discountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.discountTableView = discountTableView;
    discountTableView.backgroundColor = self.view.backgroundColor;
    discountTableView.delegate = self;
    discountTableView.dataSource = self;
    
//    discountTableView.bounces = NO;
    
    [self.view addSubview:discountTableView];
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
//    
//    
//    
//    backView.backgroundColor = self.view.backgroundColor;
//    
//    [self.view addSubview:backView];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.discountArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDDiscountCell *cell = [SDDiscountCell cellWithTableView:tableView];
    
    cell.discount = self.discountArray[indexPath.section];
    
    cell.discountType = self.discountType;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 270 * SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.navigationController pushViewController:[[SDLoanDetailController alloc] init] animated:YES];
}



- (void)addRightButton{

    if ([self.discountType isEqualToString:@"2"]) return;
    
    UIButton *sharedButton = [UIButton buttonWithTitle:@"历史优惠券" titleColor:FDColor(34, 34, 34) titleFont:14];
    
    sharedButton.frame = CGRectMake(SCREENWIDTH - 100, 20, 100, 44);
    
    [self.navBarContainer addSubview:sharedButton];
    
    [sharedButton addTarget:self action:@selector(historyDiscountButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)noContentUIWithImageNamed:(NSString *)named{
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:named]];
    [imageView sizeToFit];
    imageView.centerX = SCREENWIDTH/2;
    imageView.y = 304 * SCALE;
    [self.view addSubview:imageView];
    
    //    [self.view addSubview:noView];
    
    CGFloat actionW = 236 * SCALE;
    CGFloat actionX = (SCREENWIDTH - actionW)/2;
    CGFloat actionY = CGRectGetMaxY(imageView.frame) + 60 * SCALE;
    CGFloat actionH = 78 * SCALE;
    
    SDLoginButton *actionButton = [[SDLoginButton alloc] initWithFrame:CGRectMake(actionX, actionY, actionW, actionH)];
    [actionButton setTitle:@"立即行动" forState:UIControlStateNormal];
    [self.view addSubview:actionButton];
    
    actionButton.titleLabel.font = [UIFont systemFontOfSize:28 * SCALE];
    
    [actionButton addTarget:self action:@selector(sharedButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)addHistoryDiscountButton{
    
    NSString *title = @"查看历史优惠券 >";
    CGFloat width = [title sizeOfMaxScreenSizeInFont:22 * SCALE].width;
    CGFloat x = (SCREENWIDTH - width)/2;
    CGFloat y = 270 * SCALE * self.discountArray.count + 34 * SCALE;
    UIButton *historyDiscountButton = [UIButton buttonWithTitle:title titleColor:FDColor(153,153,153) titleFont:22 * SCALE];
    historyDiscountButton.frame = CGRectMake(x, y, width, 50 * SCALE);
    self.historyDiscountButton = historyDiscountButton;
    [self.discountTableView addSubview:historyDiscountButton];
    
    [historyDiscountButton addTarget:self action:@selector(historyDiscountButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)historyDiscountButtonDidClicked{

    SDMyDiscountController *historyDiscount = [[SDMyDiscountController alloc] init];
    
    historyDiscount.discountType = @"2";
    historyDiscount.historyDiscountButton.hidden = YES;
    
    [self.navigationController pushViewController:historyDiscount animated:YES];
    
    
}

- (void)sharedButtonDidClicked{
    
    CGFloat height = 184 * SCALE;
    
    SDSharedView *sharedView = [[SDSharedView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - height, SCREENWIDTH, height)];
    
    sharedView.delegate = self;
    
    self.sharedView = sharedView;
    
    [sharedView show];
    
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













