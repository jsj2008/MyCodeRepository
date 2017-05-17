//
//  EconomicData.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/6/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface EconomicData : AbstractJsonData

jsonValueInterface(Guid, NSString *)
jsonValueInterface(Date, NSString *)
jsonValueInterface(Time, NSString *)
jsonValueInterface(PublishedTime, NSString *)
jsonValueInterface(EconomicData, NSString *)
jsonValueInterface(ForecastsValue, NSString *)

jsonValueInterface(BeforeTheValue, NSString *)
jsonValueInterface(InputTime, NSDate *)
jsonValueInterface(Dealer, NSString *)

jsonValueInterface(Country, NSString *)
jsonValueInterface(Level, NSString *)

@property NSString *sortTag;

@end
