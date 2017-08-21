//
//  LukcyRecordDetailResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/17.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

#import "LuckyConfirmConsigneeModel.h"
#import "LuckyRecordItemModel.h"
#import "LRDetailExpressModel.h"

@interface LukcyRecordDetailResultModel : BaseModel
@property (nonatomic, strong) LuckyConfirmConsigneeModel *address;
@property (nonatomic, strong) LuckyRecordItemModel *award;
@property (nonatomic, strong) NSArray <LRDetailExpressModel>*express;
@end
