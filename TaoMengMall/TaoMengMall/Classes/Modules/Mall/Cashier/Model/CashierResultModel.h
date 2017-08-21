//
//  CashierResultModel.h
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol CashierResultModel

@end

@interface CashierResultModel : BaseModel

@property (nonatomic, strong) NSString *payId;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, assign) NSInteger totalDeposit;
@property (nonatomic, strong) NSString<Optional> *failLink;
@property (nonatomic, strong) NSString<Optional> *successLink;

@property (nonatomic, assign) BOOL showWeiXin;
@end
