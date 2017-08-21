//
//  ItemInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ImageUnitModel.h"
#import "ITSkuInfoModel.h"
#import "ITCoverImageModel.h"
#import "ITDetailContentModel.h"

@protocol ItemInfoModel

@end

@interface ItemInfoModel : BaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString<Optional> *oPrice;
@property (nonatomic, strong) NSString<Optional> *discountAmount;
@property (nonatomic, strong) NSString<Optional> *city;
@property (nonatomic, strong) NSString *discountInfo;
@property (nonatomic, strong) ITCoverImageModel *coverImage;
@property (nonatomic, strong) NSArray<ITDetailContentModel> *detailContent;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) ITSkuInfoModel<Optional> *skuInfo;
@property (nonatomic,strong) NSString<Optional> *type;

@property (nonatomic,strong) NSString<Ignore> *servicePrice;
@end
