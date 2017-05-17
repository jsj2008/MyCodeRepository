//
//  HistoricData.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/5.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface HistoricData : AbstractJsonData

jsonValueInterface(DataTime,    long long)
jsonValueInterface(QuoteDay,    NSString *)
jsonValueInterface(OpenPrice,   double)
jsonValueInterface(HighPrice,   double)
jsonValueInterface(LowPrice,    double)
jsonValueInterface(ClosePrice,  double)
jsonValueInterface(Volume,      double)
jsonValueInterface(Amount,      double)

@end
