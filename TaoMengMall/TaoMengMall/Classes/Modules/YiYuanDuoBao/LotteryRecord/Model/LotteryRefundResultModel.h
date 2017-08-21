//
//  LotteryRefundResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/30.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LotteryRefundItemModel.h"

@interface LotteryRefundResultModel : BaseModel

@property (nonatomic, strong) LotteryRefundItemModel *item;
@property (nonatomic, strong) NSString *allParticipantTimes;
@property (nonatomic, strong) NSString *participantTimes;
@property (nonatomic, strong) NSString *refund;
@end
