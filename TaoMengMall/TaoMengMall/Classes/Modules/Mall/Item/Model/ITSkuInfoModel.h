//
//  ITSkuInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ITPropertyModel.h"
#import "ITStockInfoModel.h"
#import "ITDefaultSkuInfoModel.h"
#import "ITSkuCoverModel.h"

@protocol ITSkuInfoModel

@end

@interface ITSkuInfoModel : BaseModel

@property (nonatomic, strong) NSArray<ITPropertyModel> *properties;
@property (nonatomic, strong) NSDictionary<ITStockInfoModel> *stockInfo;
@property (nonatomic, strong) NSArray<ITSkuCoverModel> *covers;
@property (nonatomic, strong) ITDefaultSkuInfoModel *defaultInfo;

@end
