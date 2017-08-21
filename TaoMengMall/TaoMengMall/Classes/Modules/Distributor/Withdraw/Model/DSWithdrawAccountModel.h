//
//  DSWithdrawAccountModel.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol DSWithdrawAccountModel <NSObject>

@end

@interface DSWithdrawAccountModel : BaseModel


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *account;

@end
