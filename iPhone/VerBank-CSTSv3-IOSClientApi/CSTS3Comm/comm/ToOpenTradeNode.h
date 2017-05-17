//
//  ToOpenTradeNode.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface ToOpenTradeNode : AbstractJsonData

jsonValueInterface(InstrumentName, NSString *)
jsonValueInterface(BuySell, int)
jsonValueInterface(Amount, double)

- (NSString *)toString;

@end
