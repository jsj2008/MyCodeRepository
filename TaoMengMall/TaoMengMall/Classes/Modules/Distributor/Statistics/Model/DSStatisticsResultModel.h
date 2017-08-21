//
//  DSStatisticsResultModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSStatisticsOrderModel.h"
#import "DSStatisticsChartModel.h"
#import "DSStatisticsOrderLegendModel.h"
#import "DSStatisticsRevenueLegendModel.h"

@interface DSStatisticsResultModel : BaseModel

@property (nonatomic, strong) DSStatisticsChartModel *chart;
@property (nonatomic, strong) DSStatisticsOrderLegendModel<Optional> *orderMetric;
@property (nonatomic, strong) DSStatisticsRevenueLegendModel<Optional> *earningMetric;
@property (nonatomic, strong) NSArray<DSStatisticsOrderModel,Optional> *list;
@end
