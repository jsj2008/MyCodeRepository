//
//  CTSkuInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CSShippingModel.h"

@protocol CTSkuInfoModel

@end

@interface CTSkuInfoModel : BaseModel

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, strong) NSString<Optional> *cartId;
@property (nonatomic, strong) NSString<Optional> *skuId;
@property (nonatomic, strong) NSString<Optional> *skuDesc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString<Optional> *oPrice;
@property (nonatomic, strong) NSString<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *link;

//1.0.0 新增
@property (nonatomic, strong) NSArray<Optional> *properties;
@property (nonatomic, strong) NSString<Optional> *itemId;
@property (nonatomic, strong) NSString<Optional> *similarLink;
@property (nonatomic, strong) NSString<Optional> *warning;
@property (nonatomic, strong) NSString<Optional> *error;

@end
