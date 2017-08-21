//
//  DSStatisticsChartModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "ChartAxisModel.h"

@interface DSStatisticsChartModel : BaseModel

@property (nonatomic, strong) ChartAxisModel *x;
@property (nonatomic, strong) ChartAxisModel *y;

@property (nonatomic, strong) NSArray<Optional> *paid;
@property (nonatomic, strong) NSArray<Optional> *delivered;

@property (nonatomic, strong) NSArray<Optional> *total;
@property (nonatomic, strong) NSArray<Optional> *distribute;

@end
