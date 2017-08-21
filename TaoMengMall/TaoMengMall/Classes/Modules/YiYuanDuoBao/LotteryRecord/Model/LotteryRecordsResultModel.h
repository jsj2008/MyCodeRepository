//
//  LotteryRecordsResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/14.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LotteryRecordsItemModel.h"

@interface LotteryRecordsResultModel : BaseModel
@property (nonatomic, copy) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSArray <LotteryRecordsItemModel>*list;
@end
