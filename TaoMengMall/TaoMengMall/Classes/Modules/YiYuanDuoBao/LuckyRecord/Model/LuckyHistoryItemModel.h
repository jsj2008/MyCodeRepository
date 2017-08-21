//
//  LuckyHistoryItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckyHistoryHeadModel.h"
#import "LuckyHistoryContentModel.h"

@protocol LuckyHistoryItemModel <NSObject>


@end

@interface LuckyHistoryItemModel : BaseModel
@property (nonatomic, strong) LuckyHistoryHeadModel *head;
@property (nonatomic, strong) LuckyHistoryContentModel *content;
@end
