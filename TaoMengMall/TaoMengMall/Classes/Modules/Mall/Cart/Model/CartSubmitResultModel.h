//
//  CartSubmitResultModel.h
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CSConsigneeInfoModel.h"
#import "CSItemInfoModel.h"
//#import "CSPlatformCouponModel.h"
#import "CSPointShowModel.h"

@protocol CartSubmitResultModel

@end

@interface CartSubmitResultModel : BaseModel

@property (nonatomic, strong) CSConsigneeInfoModel<Optional> *consigneeInfo;
@property (nonatomic, strong) NSArray<CSItemInfoModel,Optional> *orderInfo;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString<Optional> *platformPromotionId;
@property (nonatomic, strong) CTDiscountInfoModel<Optional> *discountInfo;

//无效订单
@property (nonatomic, strong) NSArray<CTSkuInfoModel,Optional> *invalids;

//@property (nonatomic, strong) NSArray<CSPlatformCouponModel,Optional> *platformCoupons;

@property (nonatomic, strong) NSArray<CSPointShowModel,Optional> *points;

//积分
//@property (nonatomic, assign) NSInteger pointAmountBalance;
//@property (nonatomic, assign) BOOL canUsePoint;
//@property (nonatomic, assign) NSInteger pointAmountMax;

//永久有效积分
//@property (nonatomic, assign) NSInteger timelessPoint;
//@property (nonatomic, assign) BOOL canUseTimelessPoint;
//@property (nonatomic, assign) NSInteger timelessPointAmountMax;
@end
