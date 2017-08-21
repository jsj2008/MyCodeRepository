//
//  MineOrderBadgeModel.h
//  FlyLantern
//
//  Created by marco on 21/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"

@interface MineOrderBadgeModel : BaseModel

@property (nonatomic, strong) NSString *unpaid;
@property (nonatomic, strong) NSString *unShipping;
@property (nonatomic, strong) NSString *unReceived;
@property (nonatomic, strong) NSString *unEvaluated;
@property (nonatomic, strong) NSString *saleAfter;

@end
