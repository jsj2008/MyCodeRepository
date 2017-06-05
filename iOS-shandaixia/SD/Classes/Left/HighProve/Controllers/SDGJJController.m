//
//  SDGJJController.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDGJJController.h"
#import "SDProvinceView.h"
#import "SDGJJ.h"
#import "SDCity.h"
#import "SDGJJTitleView.h"
#import "SDGJJView.h"


@interface SDGJJController ()<SDGJJTitleViewDelegate,SDGJJViewDelegate>

@property (nonatomic, strong) NSArray *gjjArray;

@property (nonatomic, weak) SDGJJView *gjjView;

@property (nonatomic, copy) NSString *taskId;

@end

@implementation SDGJJController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.view.backgroundColor = SDWhiteColor;
    
}

- (void)getData{
    
    FDLog(@"self.channelType - %@,self.city.code - %@",self.channelType,self.city.code);
    
    [SDGJJ getGJJInfoWithChannelType:self.channelType channelCode:self.city.code finishedBlock:^(id object,NSString *taskId) {
        
        if (!((NSArray *)object).count) {
            
            return;
        }
        
        
        
        self.gjjArray = object;
        self.taskId = taskId;
        
        if (self.gjjArray.count == 1) {
            
            SDGJJ *gjj = self.gjjArray[0];
            
            [self createNavBarWithTitle:gjj.label];
            
            [self gjjTitleViewButtonDidClicked:0];
            
        }else{
        
            
            
            
            [self createNavBarWithTitle:@"" titleColor:nil backImageNamed:@"icon_white_move_normal" backGroundColor:nil];
            
            [self addTitle];
            
            [self gjjTitleViewButtonDidClicked:0];
        }
        
        CGFloat height = 0;
        
        if (self.gjjArray.count) {
            
            for (SDGJJ *gjj in self.gjjArray) {
                
                if (gjj.captcha) {
                    
                    if (gjj.fields.count >= 3) {
                        
                        
                        CGFloat x = 100 * SCALE * (gjj.fields.count - 2);
                        
                        if (x > height) {
                            
                            height = x;
                        }
                        
                    }
                    
                    
                }
                
            }
            
            
            
        }
        
        [self addUIWithHeight:height];
        
    } failuredBlock:^(id object) {
        
    }];
}

- (void)addUIWithHeight:(CGFloat)height{

    CGFloat noticeY = 520 * SCALE + 314 * SCALE - 64 + height;
    
    for (SDGJJ *gjj in self.gjjArray) {
        
        FDLog(@"capture - %@",@(gjj.captcha));
        
//        if ([gjj.captcha isEqual:@(1)] && self.gjjArray.count == 3) {
//            
//            noticeY += 100 * SCALE;
//        }
    }
    
    NSString *notice;
    if ([self.channelType isEqualToString:@"GJJ"]) {
        
        notice = @"gongjijin_noticeLabel";
        
    }else if ([self.channelType isEqualToString:@"SHE_BAO"]) {
        
        notice = @"sheBao_noticeLabel";
    }else{
    
        notice = @"xuexinwang_noticeLabel";
    }
   
    
    UIImageView *noticeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:notice]];
    [noticeImageView sizeToFit];
    noticeImageView.x = 40 * SCALE;
    noticeImageView.y = noticeY;
    
    [self.view addSubview:noticeImageView];
    
    
    //保障文本
    UILabel *safeLabel = [UILabel labelWithText:@"我们将依法保障你的个人信息安全" textColor:FDColor(153,153,153) font:22 * SCALE textAliment:1];
    safeLabel.frame = CGRectMake(0, SCREENHEIGHT - 52 * SCALE, SCREENWIDTH, 22 * SCALE);
    [self.view addSubview:safeLabel];
}

- (void)addTitle{

    SDGJJTitleView *gjjTitleView = [[SDGJJTitleView alloc] initWithFrame:CGRectMake(0, 30, 480 * SCALE, 60 * SCALE) gjjArray:self.gjjArray];
    gjjTitleView.centerX = SCREENWIDTH/2;
    gjjTitleView.delegate = self;
    [self.navBarContainer addSubview:gjjTitleView];
    
    
}

- (void)gjjTitleViewButtonDidClicked:(NSInteger)tag{

    CGFloat y = 314 * SCALE - 64;
    CGFloat h = SCREENHEIGHT - y;
    
    [self.gjjView removeFromSuperview];
    
    SDGJJView *gjjView = [[SDGJJView alloc] initWithFrame:CGRectMake(0, y, SCREENWIDTH, h) gjj:self.gjjArray[tag]];
    
    gjjView.city = self.city;
    gjjView.channelType = self.channelType;
    gjjView.taskId = self.taskId;
    self.gjjView = gjjView;
    gjjView.delegate = self;
    
    [self.view addSubview:gjjView];
}

- (void)gjjViewVerifyStatus:(NSString *)status{

    if ([status isEqualToString:@"1"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    
        [self gjjTitleViewButtonDidClicked:0];
    }
}

@end








