//
//  ChartAxisModel.h
//  StarLantern
//
//  Created by marco on 12/1/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface ChartAxisModel : BaseModel

@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString<Optional> *isShow;
@property (nonatomic, strong) NSArray<Optional> *values;
@end
