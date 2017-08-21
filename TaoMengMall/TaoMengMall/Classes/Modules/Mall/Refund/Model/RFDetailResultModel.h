//
//  RFDetailResultModel.h
//  YouCai
//
//  Created by marco on 6/13/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface RFDetailResultModel : BaseModel

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *refundPriceByOldWay;
@property (nonatomic, strong) NSString *refundTime;

@end
