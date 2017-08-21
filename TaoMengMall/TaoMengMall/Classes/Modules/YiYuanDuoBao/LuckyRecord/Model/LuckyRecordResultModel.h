//
//  LuckyRecordResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckyRecordItemModel.h"

@interface LuckyRecordResultModel : BaseModel

@property (nonatomic, strong) NSArray<LuckyRecordItemModel> *list;

@end
