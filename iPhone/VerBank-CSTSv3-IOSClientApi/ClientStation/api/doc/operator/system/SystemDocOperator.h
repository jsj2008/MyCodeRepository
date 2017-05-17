//
//  SystemDocOperator.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemDocOperator : NSObject

+ (SystemDocOperator *)getInstance;

- (Boolean)loadBasicCurrency;
- (Boolean)loadSystemConfig;

@end
