//
//  DSRevenueDetailModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol DSRevenueDetailModel <NSObject>

@end

@interface DSRevenueDetailModel : BaseModel
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString<Optional> *earning;

@end
