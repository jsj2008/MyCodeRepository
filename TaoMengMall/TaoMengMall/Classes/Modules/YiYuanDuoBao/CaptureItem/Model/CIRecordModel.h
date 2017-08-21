//
//  CIRecordModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "CIRecordItemModel.h"

@interface CIRecordModel : BaseModel
@property (nonatomic, strong) NSString <Optional>*beginTime;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSArray<CIRecordItemModel,Optional> *list;

@end
