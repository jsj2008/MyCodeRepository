//
//  ToCloseTradeNode.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface ToCloseTradeNode : AbstractJsonData

jsonValueInterface(Ticket, long long)
jsonValueInterface(Splitno, int)
jsonValueInterface(Amount, double)

- (NSString *)toString;

@end
