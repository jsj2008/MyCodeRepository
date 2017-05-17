//
//  TikValue.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface TikValue : AbstractJsonData

jsonValueInterface(TikTime, long long)
jsonValueInterface(Bid, double)
jsonValueInterface(Ask, double)
jsonValueInterface(Volume, double)
jsonValueInterface(Amount, double)

@end
