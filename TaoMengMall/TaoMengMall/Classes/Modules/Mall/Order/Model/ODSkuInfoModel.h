//
//  ODSkuInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ODCashBackModel.h"

typedef NS_ENUM(NSUInteger, ODRefundStatus) {
    ODRefundStatusNone       = 0,
    ODRefundStatusRefunding  = 2,
    ODRefundStatusFinish     = 3,
    ODRefundStatusRejected   = 4,
};

@protocol ODSkuInfoModel

@end

@interface ODSkuInfoModel : BaseModel

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *skuDesc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString<Optional> *oPrice;

@property (nonatomic, assign) NSInteger refundStatus;
@property (nonatomic, strong) NSString<Optional> *refundLink;
@property (nonatomic, strong) NSString<Optional> *refundStatusShow;
@property (nonatomic, strong) NSString<Optional> *itemLink;

@property (nonatomic,strong) NSString<Optional> *serviceCharge;
@property (nonatomic,strong) ODCashBackModel<Optional>*cashback;

@end
