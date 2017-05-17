//
//  KeyNotFundException.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/2.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "KeyNotFundException.h"

@implementation KeyNotFundException

- (id)initWithKeyName:(NSString *)keyName  Object:(NSObject *)key  Des:(NSString *)des{
    return [super initWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%@=%@ . %@", keyName, key, des] userInfo:nil];
}

- (id)initWithKeyName:(NSString *)keyName  Object:(NSObject *)key{
    return [self initWithKeyName:keyName  Object:key  Des:@""];
}
@end
