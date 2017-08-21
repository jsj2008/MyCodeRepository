//
//  DSCustomerPromoteResultModel.h
//  CarKeeper
//
//  Created by marco on 3/1/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "ShareInfoModel.h"

@interface DSCustomerPromoteResultModel : BaseModel

@property (nonatomic, strong) ShareInfoModel *share;
@property (nonatomic, strong) NSString<Optional> *content;
@end
