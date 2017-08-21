//
//  LRDetailResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LRDetailRecordModel.h"

@interface LRDetailResultModel : BaseModel

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *announceTime;
@property (nonatomic, copy) NSString *myAmount;
@property (nonatomic, copy) NSString <Optional>*luckyNumber;
@property (nonatomic, strong) NSArray <LRDetailRecordModel,Optional>*list;
@property (nonatomic, strong) NSString <Optional>*numbers;


@end
