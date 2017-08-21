//
//  DSHomeResultModel.h
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@interface DSHomeResultModel : BaseModel

@property (nonatomic, strong) NSString *accumulatedIncome;
@property (nonatomic, strong) NSString *recentOrder;
@property (nonatomic, strong) NSString *recentIncome;

@end
