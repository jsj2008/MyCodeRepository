//
//  PointDetailResultModel.h
//  CarKeeper
//
//  Created by 任梦晗 on 17/3/7.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "PointDetailUsesModel.h"

@interface PointDetailResultModel : BaseModel

@property (nonatomic,strong) NSString<Optional> *balance;
@property (nonatomic,strong) PointDetailUsesModel<Optional> *uses;

@end
