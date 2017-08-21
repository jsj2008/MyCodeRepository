//
//  DSDistributorModel.h
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol DSCustomerModel <NSObject>

@end

@interface DSCustomerModel : BaseModel
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *desc;

@end
