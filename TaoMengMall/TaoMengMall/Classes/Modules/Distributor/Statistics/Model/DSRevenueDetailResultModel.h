//
//  DSRevenueDetailResultModel.h
//  CarKeeper
//
//  Created by marco on 3/2/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import "DSRevenueDetailModel.h"

@interface DSRevenueDetailResultModel : BaseModel


@property (nonatomic, strong) NSArray<DSRevenueDetailModel,Optional> *list;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;

@property (nonatomic, strong) NSString<Optional> *salesVolume;
@property (nonatomic, strong) NSString<Optional> *profit;

@end
