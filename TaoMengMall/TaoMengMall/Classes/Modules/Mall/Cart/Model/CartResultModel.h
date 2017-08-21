//
//  CartResultModel.h
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CartInfoModel.h"

@protocol CartResultModel

@end

@interface CartResultModel : BaseModel

@property (nonatomic, strong) NSArray<CartInfoModel, Optional> *cartInfo;
@property (nonatomic, strong) NSArray<CTSkuInfoModel,Optional> *invalidSkus;
@end
