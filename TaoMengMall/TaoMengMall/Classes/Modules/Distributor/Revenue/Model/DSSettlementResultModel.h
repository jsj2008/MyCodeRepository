//
//  DSSettlementResultModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSSettlementIncomeModel.h"

@interface DSSettlementResultModel : BaseModel

@property (nonatomic, strong) NSArray<DSSettlementIncomeModel,Optional> *list;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString<Optional> *totalBalance;

@end
