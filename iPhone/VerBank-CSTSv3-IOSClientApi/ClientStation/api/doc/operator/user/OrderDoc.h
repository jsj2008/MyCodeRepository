//
//  OrderDoc.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOrder.h"
@interface OrderDoc : NSObject

- (NSMutableArray *)getTOrderByAccountList:(long long)account;
- (NSMutableArray *)getTOrderByInstrumentList:(NSString *)instrumen;

- (TOrder *)getTOrder:(long long)orderID;
- (NSArray *)getTOrders;

- (void)removeOrder:(long long)orderID;
- (void)addOrder:(TOrder *)order;
- (void)addOrders:(NSArray *)orders;
- (void)clearOrder;

@end
