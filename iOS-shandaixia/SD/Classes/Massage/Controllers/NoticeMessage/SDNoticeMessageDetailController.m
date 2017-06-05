//
//  SDNoticeMessageDetailController.m
//  SD
//
//  Created by LayZhang on 2017/5/24.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDNoticeMessageDetailController.h"
#import "FDTopLabel.h"
#import "SDMassages.h"

@interface SDNoticeMessageDetailController ()

//时间
@property (nonatomic, weak) UILabel *timeLabel;
//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation SDNoticeMessageDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = FDColor(243, 245, 249);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"我的消息"];
    
    [self addContent];
}

- (void)addContent{
    
    //白色背景
    UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:[UIColor whiteColor]]];
    backView.frame = CGRectMake(0, 74, SCREENWIDTH, SCREENHEIGHT - 74);
    [self.view addSubview:backView];
    
    /** 系统通知 */
    UILabel *noteLabel = [UILabel labelWithText:@"系统通知" textColor:FDColor(34, 34, 34) font:30 * SCALE textAliment:NSTextAlignmentCenter];
    [backView addSubview:noteLabel];
    noteLabel.frame = CGRectMake(0, 30, SCREENWIDTH, 30 * SCALE);
    
    if ([self.massages.pushType isEqualToString:@"1"]) {
        
        noteLabel.text = @"系统消息";
    }else{
        
        noteLabel.text = @"活动消息";
    }
    
    /** 时间 */
    UILabel *timeLabel = [UILabel labelWithText:@"2012-12-25" textColor:FDColor(153, 153, 153) font:20 * SCALE textAliment:NSTextAlignmentCenter];
    [backView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    timeLabel.frame = CGRectMake(0, CGRectGetMaxY(noteLabel.frame) + 15, SCREENWIDTH, 20 * SCALE);
    
    timeLabel.text = [FDDateFormatter interceptTimeStampFromStr:_massages.gmtCreate];;
    
    //阴影
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(240, 240, 240)]];
    [backView addSubview:lineImageView];
    lineImageView.frame = CGRectMake(10, CGRectGetMaxY(timeLabel.frame) + 15, SCREENWIDTH - 20, 1);
    
    /** 内容 */
    FDTopLabel *contentLabel = [FDTopLabel labelWithText:self.massages.content
                                               textColor:FDColor(34, 34, 34) font:24 * SCALE textAliment:NSTextAlignmentLeft];
    [backView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    contentLabel.numberOfLines = 0;
    contentLabel.frame = CGRectMake(10, CGRectGetMaxY(lineImageView.frame) + 22, SCREENWIDTH - 20, backView.height - (CGRectGetMaxY(lineImageView.frame) + 22));
    
}

- (void)leftBtnDidTouch{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
