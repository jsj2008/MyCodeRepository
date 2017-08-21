//
//  DSDistributorListResultModel.h
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSDistributorModel.h"

@interface DSCustomerListResultModel : BaseModel

@property (nonatomic, strong) NSArray<DSDistributorModel,Optional> *list;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;
@end
