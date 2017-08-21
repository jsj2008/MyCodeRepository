//
//  OrderListResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "OrderListModel.h"

@protocol OrderListResultModel

@end

@interface OrderListResultModel : BaseModel

@property (nonatomic, strong) OrderListModel<Optional> *orders;

@end
