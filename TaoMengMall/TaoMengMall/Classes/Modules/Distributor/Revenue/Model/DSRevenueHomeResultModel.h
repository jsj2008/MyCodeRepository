//
//  DSRevenueHomeResultModel.h
//  CarKeeper
//
//  Created by marco on 3/3/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@interface DSRevenueHomeResultModel : BaseModel

@property (nonatomic, strong) NSString *withdrawAmount;
@property (nonatomic, strong) NSString *disableAmount;
@property (nonatomic, strong) NSString *settledAmount;
@property (nonatomic, strong) NSString *unsettledAmount;

@end
