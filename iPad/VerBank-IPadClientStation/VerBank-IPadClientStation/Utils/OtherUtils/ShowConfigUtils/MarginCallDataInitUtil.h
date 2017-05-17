//
//  MarginCallDataInitUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/26.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarginCallDataInitUtil : NSObject

//+ (MarginCallDataInitUtil *)getInstance;

- (NSDictionary *)getMarginCallDic;

- (NSString *) getEquity2MaginOpen;

@end
