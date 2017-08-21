//
//  TopUpRecordItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/20.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "TopUpRecordHeadModel.h"
#import "TopUpRecordContentModel.h"

@protocol TopUpRecordItemModel <NSObject>



@end

@interface TopUpRecordItemModel : BaseModel
@property (nonatomic, strong) TopUpRecordHeadModel <Optional>*head;
@property (nonatomic, strong) TopUpRecordContentModel *content;

@end
