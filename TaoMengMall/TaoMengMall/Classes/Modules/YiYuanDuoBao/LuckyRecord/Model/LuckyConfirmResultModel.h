//
//  LuckyConfirmResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/16.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "LuckyConfirmItemModel.h"
#import "LuckyConfirmActivityModel.h"
#import "LuckyConfirmConsigneeModel.h"

@interface LuckyConfirmResultModel : BaseModel
@property (nonatomic, strong) LuckyConfirmItemModel *item;
@property (nonatomic, strong) LuckyConfirmActivityModel *activity;
@property (nonatomic, strong) LuckyConfirmConsigneeModel <Optional>*consignee;
@end
