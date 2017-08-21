//
//  CSItemInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CTShopInfoModel.h"
#import "CTSkuInfoModel.h"

@protocol CSItemInfoModel

@end

@interface CSItemInfoModel : BaseModel

@property (nonatomic, strong) CTShopInfoModel *shopInfo;
@property (nonatomic, strong) NSArray<CTSkuInfoModel> *skuInfo;
//@property (nonatomic, strong) NSString *shippingFee;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString<Optional> *shippingTemplateId;

//邮费(仅用于确认订单)
@property (nonatomic, strong) NSArray<CSShippingModel,Optional> *shippingList;
@end
