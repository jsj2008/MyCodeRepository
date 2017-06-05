//
//  SDUserDetail.h
//  SD
//
//  Created by 余艾星 on 17/3/3.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDUserVerifyDetail : NSObject


@property (nonatomic, copy) NSString *userId;

//实名认证状态 0未认证，1认证通过
@property (nonatomic, copy) NSNumber *autonymStatus;

//活体认证，0未认证，1认证通过
@property (nonatomic, copy) NSNumber *ocrStatus;

//亲属关系认证状态，0未认证，1认证通过
@property (nonatomic, copy) NSNumber *kinsfolkStatus;

//运营商认证状态，0未认证，1认证通过
@property (nonatomic, copy) NSNumber *operatorStatus;

//运营商类型 1移动，2联通，3电信，4其他
@property (nonatomic, copy) NSNumber *operatorType;

//芝麻信用分，0为未认证
@property (nonatomic, copy) NSNumber *zmPoints;

//京东认证 ，0未认证，1认证通过
@property (nonatomic, copy) NSNumber *jdStatus;

//淘宝认证0未认证，1认证通过
@property (nonatomic, copy) NSNumber *tbStatus;

//社保认证0未认证，1认证通过
@property (nonatomic, copy) NSNumber *sbStatus;

//公积金认证0未认证，1认证通过
@property (nonatomic, copy) NSNumber *gjjStatus;

//央行征信0未认证，1认证通过
@property (nonatomic, copy) NSNumber *yhStatus;

//学信网0未认证，1认证通过
@property (nonatomic, copy) NSNumber *xueStatus;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userVerifyDetailWithDict:(NSDictionary *)dict;

//用户详情，用户状态（/detail/userStatic）
+ (void)getUserVerifyDetailFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end












