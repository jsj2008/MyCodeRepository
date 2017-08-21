//
//  LotteryRecordsItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LRWinnerModel.h"
#import "LRIDetailModel.h"

@protocol LotteryRecordsItemModel <NSObject>


@end

@interface LotteryRecordsItemModel : BaseModel

@property (nonatomic, strong) LRIDetailModel *item;
@property (nonatomic, copy) NSString *myAmount;
@property (nonatomic, strong) NSArray <Optional>*buttons;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, copy) NSString *detailLink;
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString <Optional>*winner;
@property (nonatomic, copy) NSString <Optional>*winnerAmount;
@property (nonatomic, strong) NSString <Optional>*refund;
@property (nonatomic, copy) NSString *singlePrice;
@end
