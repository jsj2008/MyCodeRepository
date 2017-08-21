//
//  ConsigneeListResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ConsigneesModel.h"

@protocol ConsigneeListResultModel

@end

@interface ConsigneeListResultModel : BaseModel

@property (nonatomic, strong) ConsigneesModel *consignees;

@end
