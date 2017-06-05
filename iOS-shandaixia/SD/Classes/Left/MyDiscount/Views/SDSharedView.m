//
//  SDSharedView.m
//  FuDai
//
//  Created by Apple on 16/8/10.
//  Copyright © 2016年 fudai. All rights reserved.
//

#import "SDSharedView.h"
#import <Social/Social.h>


@interface SDSharedView ()

//微信好友
@property (nonatomic, weak) UIButton *wechatFriendButton;

//微信朋友圈
@property (nonatomic, weak) UIButton *wechatZoneButton;

//新浪微博
@property (nonatomic, weak) UIButton *sinaButton;

//QQ好友
@property (nonatomic, weak) UIButton *qqFriendButton;

//QQ空间
@property (nonatomic, weak) UIButton *qqZoneButton;

//复制链接
@property (nonatomic, weak) UIButton *copContentButton;

//背景图
@property (nonatomic,weak) UIButton *shadowView;

@end

@implementation SDSharedView

static SDSharedView *_instance;

+ (instancetype)sharedSDLoadView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        CGFloat height = 682 * SCALE;
        
        _instance = [[self alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, height)];

        
        
    });
    
    return _instance;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_share_background"]];
//        imageView.frame = self.bounds;
//        imageView.userInteractionEnabled = YES;
//        [self addSubview:imageView];
        
        //微信好友
        UIButton *wechatFriendButton = [UIButton buttonWithTitle:@"" titleColor:SDRandomColor titleFont:0 imageNamed:@"icon_share_weixin"];
        [self addSubview:wechatFriendButton];
        self.wechatFriendButton = wechatFriendButton;
        
        wechatFriendButton.tag = SDSharedWeChatFriend;
        
        [wechatFriendButton addTarget:self action:@selector(sharedButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //微信朋友圈
        UIButton *wechatZoneButton = [UIButton buttonWithTitle:@"" titleColor:SDRandomColor titleFont:0 imageNamed:@"icon_share_pengyou"];
        [self addSubview:wechatZoneButton];
        self.wechatZoneButton = wechatZoneButton;
        
        wechatZoneButton.tag = SDSharedWeChatZone;
        
        [wechatZoneButton addTarget:self action:@selector(sharedButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //QQ好友
        UIButton *qqFriendButton = [UIButton buttonWithTitle:@"" titleColor:SDRandomColor titleFont:0 imageNamed:@"icon_share_QQ"];
        [self addSubview:qqFriendButton];
        self.qqFriendButton = qqFriendButton;
        
        qqFriendButton.tag = SDSharedQQFriend;
        
        [qqFriendButton addTarget:self action:@selector(sharedButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //QQ空间
//        UIButton *qqZoneButton = [UIButton buttonWithTitle:@"" titleColor:SDRandomColor titleFont:0 imageNamed:@"product_share_Qzone"];
//        [self addSubview:qqZoneButton];
//        self.qqZoneButton = qqZoneButton;
//        
//        qqZoneButton.tag = SDSharedQQzone;
//        
//        [qqZoneButton addTarget:self action:@selector(sharedButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //新浪微博
        UIButton *sinaButton = [UIButton buttonWithTitle:@"" titleColor:SDRandomColor titleFont:0 imageNamed:@"icon_share_weibo"];
        [self addSubview:sinaButton];
        self.sinaButton = sinaButton;
        
        sinaButton.tag = SDSharedSina;
        
        [sinaButton addTarget:self action:@selector(sharedButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
//        //复制链接
//        UIButton *copContentButton = [UIButton buttonWithTitle:@"" titleColor:SDRandomColor titleFont:0 imageNamed:@"product_share_copy"];
//        [self addSubview:copContentButton];
//        self.copContentButton = copContentButton;
//        
//        copContentButton.tag = SDSharedCopyContent;
//        
//        [copContentButton addTarget:self action:@selector(sharedButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)sharedButtonDidClicked:(UIButton *)button{
    
    SDSharedType type = (SDSharedType)button.tag;
    
//    NSString *tag = [NSString stringWithFormat:@"%@",@(button.tag)];
    
//    SDLog(@"tag ----- %@",@(button.tag));
    
//    [SDNotificationCenter postNotificationName:SDSharedButtonDidClickedNotification object:nil userInfo:@{SDSharedTypeString:tag}];
    
    if ([self.delegate respondsToSelector:@selector(sharedViewSharedButtonDidClicked:)]) {
        
        [self.delegate sharedViewSharedButtonDidClicked:type];
    }
    
    

    switch (type) {
            
            /*
             
             SDSharedWeChatFriend,
             SDSharedWeChatZone,
             SDSharedSina,
             SDSharedQQFriend,
             SDSharedQQzone,
             SDSharedCopyContent
             */
            
        case SDSharedWeChatFriend:
            
            break;
        case SDSharedWeChatZone:
            
            break;
        case SDSharedSina:
            
        {
            
            
            
        }
            
            break;
        case SDSharedQQFriend:
            
        {
            
            
            
        }
            
            break;
        case SDSharedQQzone:
            
            break;
        case SDSharedCopyContent:
            
        {
        
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            
            NSString *string = [FDUserDefaults objectForKey:@""];
            
            [pab setString:string];
            
           
            
        }
            
            break;
            
        default:
            break;
    }
    
}

//微信好友
- (void)wechatFriendButtonDidClicked{

    
}

 //微信朋友圈
- (void)wechatZoneButtonDidClicked{
    
    
}

//新浪微博
- (void)sinaButtonDidClicked{
 
}

//QQ好友
- (void)qqFriendButtonDidClicked{
    
    
}

//QQ空间
- (void)qqZoneButtonDidClicked{
    
    
}

//复制链接
- (void)copContentButtonDidClicked{
    
    
    
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    CGFloat blank = self.width/8;
    
    self.wechatZoneButton.centerY = self.wechatFriendButton.centerY = self.qqFriendButton.centerY = self.sinaButton.centerY = self.height/2;
    
    self.wechatFriendButton.centerX = blank;
    self.wechatZoneButton.centerX = 3 * blank;
    self.qqFriendButton.centerX = 5 * blank;
    self.sinaButton.centerX = 7 * blank;
    
//    CGFloat height = 166*SCALE;
//    CGFloat width = 120*SCALE;
//    
//    CGFloat wechatY = self.height - 2*height - 100*SCALE;
//    CGFloat qqY = self.height - height - 50*SCALE;
//    CGFloat blank = 90 * SCALE;
//    CGFloat margin = (SCREENWIDTH - 3 * width - blank * 2)/2;
//    
//    self.wechatFriendButton.frame = CGRectMake(blank, wechatY, width, height);
//    self.wechatZoneButton.frame = CGRectMake(width + blank + margin, wechatY, width, height);
//    self.sinaButton.frame = CGRectMake(width * 2 + blank + margin * 2, wechatY, width, height);
//    self.qqFriendButton.frame = CGRectMake(blank, qqY, width, height);
//    self.qqZoneButton.frame = CGRectMake(width + blank + margin, qqY, width, height);
//    self.copContentButton.frame = CGRectMake(width * 2 + blank + margin * 2, qqY, width, height);;
    
}

- (void)show{
    
//    SDLog(@"show - ------------");

    //背景图
    UIButton *shadowView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    [shadowView addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    shadowView.backgroundColor = [UIColor blackColor];
    
    shadowView.alpha = 0.6;
    
    self.shadowView = shadowView;
    [[[UIApplication sharedApplication].windows lastObject] addSubview:shadowView];
    
    
    
    CGFloat height = self.height;
    
    self.y = SCREENHEIGHT;
    
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.y = SCREENHEIGHT - height;
        
    }];
}

- (void)remove{

    [UIView animateWithDuration:0.25 animations:^{
        
        self.y = SCREENHEIGHT;
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
        
        [self.shadowView removeFromSuperview];
        
    });
    
}

@end
























