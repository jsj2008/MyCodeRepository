//
//  CityModel.h
//  YouCai
//
//  Created by marco on 6/12/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "AreaModel.h"

@protocol CityModel <NSObject>

@end


@interface CityModel : BaseModel
@property (nonatomic, strong) AreaModel *n;
@property (nonatomic, strong) NSArray<AreaModel,Optional> *a;
@end
