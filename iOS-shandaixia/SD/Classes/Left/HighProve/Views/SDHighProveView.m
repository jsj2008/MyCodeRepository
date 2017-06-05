//
//  SDHighProveView.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/13.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDHighProveView.h"
#import "SDHighProveButton.h"
#import "SDUserVerifyDetail.h"

@interface SDHighProveView ()

//淘宝认证
@property(nonatomic, weak) SDHighProveButton *taoBaoButton;

//京东认证
@property(nonatomic, weak) SDHighProveButton *jinDongButton;

//央行征信
@property(nonatomic, weak) SDHighProveButton *yangHangButton;

//社保认证
@property(nonatomic, weak) SDHighProveButton *sheBaoButton;

//公积金认证
@property(nonatomic, weak) SDHighProveButton *gongJiJinButton;

//暂未开放
@property(nonatomic, weak) SDHighProveButton *xueXinWangButton;

@end

@implementation SDHighProveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //淘宝认证
        SDHighProveButton *taoBaoButton = [SDHighProveButton buttonWithImage:@"icon_btn_taobao_normal" backImageNamed:nil];
        self.taoBaoButton = taoBaoButton;
        [self addSubview:taoBaoButton];
        taoBaoButton.tag = SDProveTypeTaobao;
        
        [taoBaoButton addTarget:self action:@selector(proveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //京东认证
        SDHighProveButton *jinDongButton = [SDHighProveButton buttonWithImage:@"icon_btn_jingdong_normal" backImageNamed:nil];
        self.jinDongButton = jinDongButton;
        [self addSubview:jinDongButton];
        jinDongButton.tag = SDProveTypeJingdong;
        
        [jinDongButton addTarget:self action:@selector(proveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //央行征信
        SDHighProveButton *yangHangButton = [SDHighProveButton buttonWithImage:@"icon_btn_yanghang_normal" backImageNamed:nil];
        self.yangHangButton = yangHangButton;
        [self addSubview:yangHangButton];
        yangHangButton.tag = SDProveTypeYanghang;
        
        [yangHangButton addTarget:self action:@selector(proveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //社保认证
        SDHighProveButton *sheBaoButton = [SDHighProveButton buttonWithImage:@"icon_btn_shebao_normal" backImageNamed:nil];
        self.sheBaoButton = sheBaoButton;
        [self addSubview:sheBaoButton];
        sheBaoButton.tag = SDProveTypeShebao;
        sheBaoButton.percentImageView.image = [UIImage imageNamed:@"highProve_10percent"];
        
        [sheBaoButton addTarget:self action:@selector(proveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //公积金认证
        SDHighProveButton *gongJiJinButton = [SDHighProveButton buttonWithImage:@"icon_btn_gongjijin_normal" backImageNamed:nil];
        self.gongJiJinButton = gongJiJinButton;
        [self addSubview:gongJiJinButton];
        gongJiJinButton.tag = SDProveTypeGongjijin;
        gongJiJinButton.percentImageView.image = [UIImage imageNamed:@"highProve_10percent"];
        
        [gongJiJinButton addTarget:self action:@selector(proveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //暂未开放
        SDHighProveButton *xueXinWangButton = [SDHighProveButton buttonWithImage:@"icon_btn_xx_normal" backImageNamed:nil];
        self.xueXinWangButton = xueXinWangButton;
        [self addSubview:xueXinWangButton];
        xueXinWangButton.tag = SDProveTypeXueXinWang;
        
        
        [xueXinWangButton addTarget:self action:@selector(proveButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}



- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat width = self.taoBaoButton.width;
    CGFloat blank = (self.width - 3 * self.taoBaoButton.width)/4;
    
    self.yangHangButton.y = self.jinDongButton.y = self.taoBaoButton.y = 0;
    self.sheBaoButton.y = self.gongJiJinButton.y = self.xueXinWangButton.y = blank + self.taoBaoButton.height;
    self.sheBaoButton.x = self.taoBaoButton.x = blank;
    self.gongJiJinButton.x = self.jinDongButton.x = blank * 2 + width;
    self.xueXinWangButton.x = self.yangHangButton.x = blank * 3 + width * 2;
    
}

- (void)proveButtonDidClicked:(SDHighProveButton *)button{

    SDProveType type = (SDProveType)button.tag;
    
    FDLog(@"type - %@",@(type));
    
    if ([self.delegate respondsToSelector:@selector(highProveViewButtonDidClicked:)]) {
        
        [self.delegate highProveViewButtonDidClicked:type];
    }
}


- (void)setUserVerifyDetail:(SDUserVerifyDetail *)userVerifyDetail{

    _userVerifyDetail = userVerifyDetail;
    
    self.taoBaoButton.percentImageView.hidden = [userVerifyDetail.tbStatus integerValue];
    _taoBaoButton.enabled = _taoBaoButton.finishedImageView.hidden = ![userVerifyDetail.tbStatus integerValue];
    
    self.jinDongButton.percentImageView.hidden = [userVerifyDetail.jdStatus integerValue];
    _jinDongButton.enabled = _jinDongButton.finishedImageView.hidden = ![userVerifyDetail.jdStatus integerValue];
    
    self.yangHangButton.percentImageView.hidden = [userVerifyDetail.yhStatus integerValue];
    _yangHangButton.enabled = _yangHangButton.finishedImageView.hidden = ![userVerifyDetail.yhStatus integerValue];
    
    self.sheBaoButton.percentImageView.hidden = [userVerifyDetail.sbStatus integerValue];
    _sheBaoButton.enabled = _sheBaoButton.finishedImageView.hidden = ![userVerifyDetail.sbStatus integerValue];
    
    self.gongJiJinButton.percentImageView.hidden = [userVerifyDetail.gjjStatus integerValue];
    _gongJiJinButton.enabled = _gongJiJinButton.finishedImageView.hidden = ![userVerifyDetail.gjjStatus integerValue];
    
    self.xueXinWangButton.percentImageView.hidden = [userVerifyDetail.xueStatus integerValue];
    _xueXinWangButton.enabled = _xueXinWangButton.finishedImageView.hidden = ![userVerifyDetail.xueStatus integerValue];
    

}

@end







