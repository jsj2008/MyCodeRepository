//
//  LuckyHistoryResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckyHistoryItemModel.h"

@interface LuckyHistoryResultModel : BaseModel
@property (nonatomic, strong) NSArray <LuckyHistoryItemModel>*list;
@end
