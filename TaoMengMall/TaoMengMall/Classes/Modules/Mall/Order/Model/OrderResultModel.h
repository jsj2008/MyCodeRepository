//
//  OrderResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ODConsigneeInfoModel.h"
#import "ODItemInfoModel.h"
#import "ODExpressModel.h"

@protocol OrderResultModel

@end

@interface OrderResultModel : BaseModel
@property (nonatomic, strong) ODExpressModel<Optional> *express;
@property (nonatomic, strong) NSString<Optional> *buyerRemark;

@property (nonatomic, strong) ODConsigneeInfoModel *consigneeInfo;
@property (nonatomic, strong) NSDictionary<Optional> *buttons;
@property (nonatomic, strong) NSArray<ODItemInfoModel> *orderInfos;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString<Optional> *statusDesc;
@property (nonatomic, strong) NSString<Optional> *payMethod;
@property (nonatomic,strong) NSString<Optional> *payTime;

@property (nonatomic, strong) NSString<Optional> *orderId;
@property (nonatomic, strong) NSString<Optional> *payLink;
@property (nonatomic, strong) NSArray<Optional> *orders;

//@property (nonatomic, strong) NSString<Optional> *permanentPoint;
//@property (nonatomic, strong) NSString<Optional> *transientPoint;
@end
