//
//  KeyNotFundException.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/2.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyNotFundException : NSException

- (id)initWithKeyName:(NSString *)keyName  Object:(NSObject *)object  Des:(NSString *)des;
- (id)initWithKeyName:(NSString *)keyName  Object:(NSObject *)object;

@end
