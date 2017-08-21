//
//  DSStatisticsPagerController.h
//  CarKeeper
//
//  Created by marco on 2/28/17.
//  Copyright © 2017 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface DSStatisticsPagerController : TTViewPagerController

@property (nonatomic, strong) NSString *selectedIndex;

//1订单 2营收
@property (nonatomic, strong) NSString *xxType;

@end
