//
//  SDGJJ.h
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"
//成功时的block
typedef void(^GJJFinishedBlock)(id object,NSString *taskId);

@interface SDGJJ : NSObject

/*
 "captcha":true,
 "fields":Array[2],
 "label":"客户号",
 "name":"login_type",
 "value":"1"
 */

@property (nonatomic, assign) BOOL captcha;

@property (nonatomic, strong) NSArray *fields;

@property (nonatomic, copy) NSString *label;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *value;



- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)gJJWithDict:(NSDictionary *)dict;

//(社保、公积金、学信网）初始化页面显示内容/loanAndSocial/initLogin)
+ (void)getGJJInfoWithChannelType:(NSString *)channelType channelCode:(NSString *)channelCode finishedBlock:(GJJFinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//(社保、公积金、学信网）获取验证码图片页面  )
+ (void)getGJJVerifyCodeWithChannelType:(NSString *)channelType channelCode:(NSString *)channelCode taskId:(NSString *)taskId finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//(社保、公积金、学信网）校验并获取数据接口/loanAndSocial/handleData
+ (void)submitGJJInfoWithChannelType:(NSString *)channelType channelCode:(NSString *)channelCode taskId:(NSString *)taskId verifyCode:(NSString *)verifyCode inputElementStr:(NSString *)inputElementStr finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;


@end
