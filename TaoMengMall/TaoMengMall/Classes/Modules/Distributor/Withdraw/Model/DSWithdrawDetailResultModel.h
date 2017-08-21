//
//  DSWithdrawDetailResultModel.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface DSWithdrawDetailResultModel : BaseModel

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *time;

@end
