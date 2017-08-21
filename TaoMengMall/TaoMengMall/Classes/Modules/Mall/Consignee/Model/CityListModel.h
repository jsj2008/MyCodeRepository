//
//  cityListModel.h
//  YouCai
//
//  Created by marco on 6/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "ProvinceModel.h"

@interface CityListModel : BaseModel
@property(nonatomic, strong) NSArray<ProvinceModel> *citylist;
@end
