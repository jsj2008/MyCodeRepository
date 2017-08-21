//
//  ODLSubOrderInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ODLSkuInfoModel.h"

@protocol ODLSubOrderInfoModel

@end

@interface ODLSubOrderInfoModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *shopName;
@property (nonatomic,strong) NSString<Optional> *shopLogo;
@property (nonatomic, strong) NSString<Optional> *shopLink;
@property (nonatomic, strong) NSArray<ODLSkuInfoModel,Optional> *skuInfo;

@end
