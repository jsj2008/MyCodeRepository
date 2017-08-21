//
//  CartInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CTShopInfoModel.h"
#import "CTSkuInfoModel.h"

@protocol CartInfoModel

@end

@interface CartInfoModel : BaseModel

@property (nonatomic, strong) CTShopInfoModel *shopInfo;
@property (nonatomic, strong) NSMutableArray<CTSkuInfoModel> *skuInfo;

@end
