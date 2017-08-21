//
//  CSAdditionInfoModel.h
//  LianWei
//
//  Created by marco on 7/17/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "CSPlatformCouponModel.h"

@interface CSAdditionInfoModel : BaseModel

//只读
//@property (nonatomic, strong) NSString *platformPromotionId;
@property (nonatomic, assign) NSInteger pointAmountBalance;
@property (nonatomic, assign) BOOL canUsePoint;
@property (nonatomic, assign) NSInteger pointAmountMax;

@property (nonatomic, assign) NSInteger timelessPoint;
@property (nonatomic, assign) BOOL canUseTimelessPoint;
@property (nonatomic, assign) NSInteger timelessPointAmountMax;

//可写
@property (nonatomic, assign) BOOL usePoint;
@property (nonatomic, assign) NSInteger  point;
@property (nonatomic, assign) BOOL useTimelessPoint;
@property (nonatomic, assign) NSInteger  tPoint;

@property (nonatomic, strong) CSPlatformCouponModel *coupon;


@end
