//
//  ODLFeedModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ODLSubOrderInfoModel.h"

@protocol ODLFeedModel

@end

@interface ODLFeedModel : BaseModel

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString<Optional> *payId;
@property (nonatomic, strong) NSString<Optional> *payLink;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *statusForShow;
@property (nonatomic, strong) NSString *shippingFee;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSArray<ODLSubOrderInfoModel> *orderInfos;
@property (nonatomic, strong) NSDictionary<Optional> *buttons;
@end
