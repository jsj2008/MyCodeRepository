//
//  SDUserCenter.h
//  SD
//
//  Created by 余艾星 on 17/3/6.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"


@interface SDUserCenter : NSObject

@property (nonatomic, copy) NSString *headPortrait;// 用户头像照片
@property (nonatomic, copy) NSString *phone;//手机号
@property (nonatomic, copy) NSString *realName;//实名认证
@property (nonatomic, copy) NSString *bankNumber;//银行卡号
@property (nonatomic, copy) NSString *relationName;//人际关系

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userCenterWithDict:(NSDictionary *)dict;


//个人中心（/detail/personageCentre）
+ (void)getUserCenterFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end
