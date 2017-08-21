//
//  ODLSkuInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ODLSkuInfoModel

@end

@interface ODLSkuInfoModel : BaseModel

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *skuDesc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString<Optional> *oPrice;
@property (nonatomic, strong) NSString<Optional> *refundStatusShow;

@end
