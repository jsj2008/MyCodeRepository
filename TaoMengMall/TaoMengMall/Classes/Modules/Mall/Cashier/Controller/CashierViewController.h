//
//  CashierViewController.h
//  HongBao
//
//  Created by Ivan on 16/2/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseViewController.h"

@interface CashierViewController : BaseViewController

@property (nonatomic,copy) NSString *vipPay;
@property (nonatomic, strong) NSString *payId;

@property (nonatomic, strong) NSString *totalPrice;

@property (nonatomic, strong) NSString *orders;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, copy) NSString *type;
@end
