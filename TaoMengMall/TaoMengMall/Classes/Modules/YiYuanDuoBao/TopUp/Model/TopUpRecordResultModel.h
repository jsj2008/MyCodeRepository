//
//  TopUPRecordResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/20.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "TopUpRecordItemModel.h"

@interface TopUpRecordResultModel : BaseModel
@property (nonatomic, strong) NSArray <TopUpRecordItemModel>*list;
@end
