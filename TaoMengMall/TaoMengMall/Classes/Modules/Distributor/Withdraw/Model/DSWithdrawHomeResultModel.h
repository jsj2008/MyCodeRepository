//
//  DSWithdrawHomeResultModel.h
//  CarKeeper
//
//  Created by marco on 3/7/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSWithdrawAccountModel.h"

@interface DSWithdrawHomeResultModel : BaseModel

@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSArray<DSWithdrawAccountModel,Optional> *accounts;

@end
