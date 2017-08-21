//
//  DSSettlementIncomeModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol DSSettlementIncomeModel <NSObject>

@end


@interface DSSettlementIncomeModel : BaseModel

@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *earning;
@end
