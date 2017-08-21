//
//  DSReceiptPaymentModel.h
//  CarKeeper
//
//  Created by marco on 3/3/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol DSReceiptPaymentModel <NSObject>

@end

@interface DSReceiptPaymentModel : BaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *link;

@end
