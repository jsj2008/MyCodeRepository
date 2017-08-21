//
//  ODItemInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ODShopInfoModel.h"
#import "ODSkuInfoModel.h"
#import "ODPointUsageModel.h"

@protocol ODItemInfoModel

@end

@interface ODItemInfoModel : BaseModel

@property (nonatomic, strong) ODShopInfoModel *shopInfo;
@property (nonatomic, strong) NSArray<ODSkuInfoModel> *skuInfo;
@property (nonatomic, strong) NSString *shippingFee;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSArray<ODPointUsageModel,Optional> *point;
@end
