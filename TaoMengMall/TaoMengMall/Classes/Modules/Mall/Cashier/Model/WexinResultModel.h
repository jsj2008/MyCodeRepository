//
//  WexinResultModel.h
//  LianWei
//
//  Created by marco on 8/10/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "ThirdPayResultModel.h"

@interface WexinResultModel : BaseModel

@property (nonatomic, strong) ThirdPayResultModel *sign;
@end
