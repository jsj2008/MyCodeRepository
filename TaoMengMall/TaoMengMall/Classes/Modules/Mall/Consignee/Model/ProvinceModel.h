//
//  CityModel.h
//  YouCai
//
//  Created by marco on 6/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "CityModel.h"
#import "AreaModel.h"

@protocol ProvinceModel

@end

@interface ProvinceModel : BaseModel
@property (nonatomic, strong) AreaModel *p;
@property (nonatomic, strong) NSArray<CityModel,Optional> *c;
@end
