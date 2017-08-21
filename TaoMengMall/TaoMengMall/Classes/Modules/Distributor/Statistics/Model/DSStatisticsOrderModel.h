//
//  DSStatisticsOrderModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol DSStatisticsOrderModel <NSObject>

@end


@interface DSStatisticsOrderModel : BaseModel

@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString<Optional> *phone;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *time;
//@property (nonatomic, strong) NSString *link;

@end
