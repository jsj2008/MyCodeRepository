//
//  SDRefundOrder.h
//  SD
//
//  Created by 余艾星 on 17/3/13.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDRefundOrder : NSObject

@property (nonatomic, copy) NSString *merOrderNo;

@property (nonatomic, copy) NSString *txnTime;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)refundOrderWithDict:(NSDictionary *)dict;


@end
