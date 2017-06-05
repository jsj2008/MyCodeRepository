//
//  SDSSQStatus.h
//  SD
//
//  Created by LayZhang on 2017/5/10.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDLoan.h"
#import "SDNetworkTool.h"

typedef NS_ENUM(NSInteger, SSQSatusCode) {
    SSQSatusCodeManual  = 0,
    SSQSatusCodeAuto    = 1
};

@interface SDSSQStatus : NSObject

@property (nonatomic, assign) SSQSatusCode ssqStatus;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)ssqStatusWithDict:(NSDictionary *)dict;

// 查询上上签是否开启 或 关闭
+ (void)querySSQStatusFinishedBlock:(FinishedBlock)finishedBlock
                      failuredBlock:(FailuredBlock)failuredBlock;

// 修改上上签状态
+ (void)modifySSQStatusIsBestsign:(NSNumber *)bestsign
                    finishedBlock:(FinishedBlock)finishedBlock
                    failuredBlock:(FailuredBlock)failuredBlock;

// 上上签 获取 signid
+ (void)getSSQSignWithLoan:(SDLoan *)loan
             finishedBlock:(FinishedBlock)finishedBlock
             failuredBlock:(FailuredBlock)failuredBlock;

// 上上签 获取 preview url
+ (void)getSSQPreview:(NSString *)signid
        finishedBlock:(FinishedBlock)finishedBlock
        failuredBlock:(FailuredBlock)failuredBlock;

// 上上签 获取手签界面
+ (void)getSignPageSignimagePc:(NSString *)signid
                 finishedBlock:(FinishedBlock)finishedBlock
                 failuredBlock:(FailuredBlock)failuredBlock;


@end
