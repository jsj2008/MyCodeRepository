//
//  SDSharedHeaderView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/1/22.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDSharedHeaderView.h"
#import "SDNumberView.h"

@interface SDSharedHeaderView ()

//顶部图片
@property (nonatomic, weak) UIImageView *topImageView;

//顶部图片
@property (nonatomic, weak) UIImageView *topShadowImageView;



//利息减减减
@property (nonatomic, weak) UIImageView *cutImageView;

//邀请注册
@property (nonatomic, weak) UILabel *inviteFriendLabel;


//查看优惠券
@property (nonatomic, weak) UILabel *showDiscountLabel;



//顶部图片
@property (nonatomic, weak) UIImageView *bottomShadowImageView;

//排行榜
@property (nonatomic, weak) UIImageView *listImageView;

//排名
@property (nonatomic, weak) UILabel *rankLabel;

//账户名
@property (nonatomic, weak) UILabel *nameLabel;

//免息金额
@property (nonatomic, weak) UILabel *sumLabel;




@end

@implementation SDSharedHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //顶部图片
        UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shared_header_image"]];
        self.topImageView = topImageView;
        [self addSubview:topImageView];
        
        //邀请人数
        SDNumberView *numberOfManView = [[SDNumberView alloc] init];
        self.numberOfManView = numberOfManView;
        [self addSubview:numberOfManView];
        [self.numberOfManView.descriptionButton setTitle:@"邀请人数" forState:UIControlStateNormal];
        
        //减免金额
        SDNumberView *discountMoneyView = [[SDNumberView alloc] init];
        self.discountMoneyView = discountMoneyView;
        [self addSubview:discountMoneyView];
        [self.discountMoneyView.descriptionButton setTitle:@"优惠金额" forState:UIControlStateNormal];
        
        numberOfManView.numberLabel.font = discountMoneyView.numberLabel.font = [UIFont systemFontOfSize:30 * SCALE];
        
        //顶部背景图片
        UIImageView *topShadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(240, 240, 240)]];
        self.topShadowImageView = topShadowImageView;
        [self addSubview:topShadowImageView];
        
        //利息减减减
        UIImageView *cutImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_text"]];
        [cutImageView sizeToFit];
        self.cutImageView = cutImageView;
        [self addSubview:cutImageView];
        
        //邀请注册
        UILabel *inviteFriendLabel = [UILabel labelWithText:@"邀请好友注册闪贷侠 APP 即可获得10元免息券。" textColor:FDColor(34,34,34) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.inviteFriendLabel = inviteFriendLabel;
        [self addSubview:inviteFriendLabel];
        
        
        //查看优惠券
        UILabel *showDiscountLabel = [UILabel labelWithText:@"获得的免息券可在 \"我的优惠券\" 中查看。" textColor:FDColor(34,34,34) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.showDiscountLabel = showDiscountLabel;
        [self addSubview:showDiscountLabel];
        
        //呼唤好友
        UIButton *callFriendButton = [UIButton buttonWithTitle:@"呼唤好友" titleColor:[UIColor whiteColor] titleFont:30 * SCALE backImageNamed:nil];
        self.callFriendButton = callFriendButton;
        [self addSubview:callFriendButton];
        callFriendButton.backgroundColor = FDColor(70, 151, 250);
        
        UIView *levelView = [[UIView alloc] init];
        [self addSubview:levelView];
        self.levelView = levelView;
        levelView.hidden = YES;
        
//        //底部背景图片
        UIImageView *bottomShadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(240, 240, 240)]];
        self.bottomShadowImageView = bottomShadowImageView;
        [levelView addSubview:bottomShadowImageView];
        
        //排行榜
        UIImageView *listImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"invite_level"]];
        [listImageView sizeToFit];
        self.listImageView = listImageView;
        [levelView addSubview:listImageView];
        
        //排名
        UILabel *rankLabel = [UILabel labelWithText:@"邀请时间" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentLeft];
        self.rankLabel = rankLabel;
        [levelView addSubview:rankLabel];
        
        
        //账户名
        UILabel *nameLabel = [UILabel labelWithText:@"手机号" textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentCenter];
        self.nameLabel = nameLabel;
        [levelView addSubview:nameLabel];
        
        
        //免息金额
        UILabel *sumLabel = [UILabel labelWithText:@"姓名  " textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentRight];
        self.sumLabel = sumLabel;
        [levelView addSubview:sumLabel];

        
    }
    
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat topH = 487 * SCALE;
    self.topImageView.frame = CGRectMake(0, 0, SCREENWIDTH, topH);
    
    CGFloat manH = 64 * SCALE;
    CGFloat manW = SCREENWIDTH/4;
    CGFloat manY = topH + 36 * SCALE;
    CGFloat manX = (SCREENWIDTH/2 - manW)/2;
    self.numberOfManView.frame = CGRectMake(manX, manY, manW, manH);
    
    self.discountMoneyView.frame = self.numberOfManView.frame;
    self.discountMoneyView.centerX = SCREENWIDTH * 0.75;
    
    CGFloat shadowH = 20 * SCALE;
    CGFloat shadowY = topH;
    self.topShadowImageView.frame = CGRectMake(0, shadowY, SCREENWIDTH, shadowH);
    
    CGFloat cutY = CGRectGetMaxY(self.numberOfManView.frame) + 34 * SCALE;
    self.cutImageView.y = cutY;
    self.cutImageView.centerX = SCREENWIDTH/2;
    
    CGFloat inviteY = CGRectGetMaxY(self.cutImageView.frame) + 36 *SCALE;
    CGFloat inviteH = 24 * SCALE;
    self.inviteFriendLabel.frame = CGRectMake(0, inviteY, SCREENWIDTH, inviteH);
    
    self.showDiscountLabel.frame = self.inviteFriendLabel.frame;
    self.showDiscountLabel.y = CGRectGetMaxY(self.inviteFriendLabel.frame) + inviteH;
    
    CGFloat callY = CGRectGetMaxY(self.showDiscountLabel.frame) + 58 * SCALE;
    CGFloat callW = 284 * SCALE;
    CGFloat callH = 80 * SCALE;
    CGFloat callX = (self.width - callW)/2;
    self.callFriendButton.frame = CGRectMake(callX, callY, callW, callH);
    self.callFriendButton.layer.cornerRadius = callH/2;
    self.callFriendButton.clipsToBounds = YES;
    
    CGFloat bottomY = CGRectGetMaxY(self.callFriendButton.frame) + 40 * SCALE;
    
    //排行榜
    CGFloat levelH = shadowH + self.listImageView.height + 72 * SCALE;
    self.levelView.frame = CGRectMake(0, bottomY, SCREENWIDTH, levelH);
    
    self.bottomShadowImageView.frame = CGRectMake(0, 0, SCREENWIDTH, shadowH);
    
    self.listImageView.y = CGRectGetMaxY(self.bottomShadowImageView.frame) + 26 * SCALE;
    self.listImageView.centerX = SCREENWIDTH/2;
    
    CGFloat rankX = 46 * SCALE;
    CGFloat rankW = 100;
    CGFloat rankY = CGRectGetMaxY(self.listImageView.frame) + 48 * SCALE;
    CGFloat rankH = 24 * SCALE;
    self.nameLabel.frame = self.sumLabel.frame = self.rankLabel.frame = CGRectMake(rankX, rankY, rankW, rankH);
    
    self.nameLabel.centerX = SCREENWIDTH/2;
    self.sumLabel.x = SCREENWIDTH - 100 - 40 * SCALE;
    
    
    
    self.numberOfManView.numberLabel.text = @"0";
    self.discountMoneyView.numberLabel.text = @"¥ 0";
    
    
}



@end






