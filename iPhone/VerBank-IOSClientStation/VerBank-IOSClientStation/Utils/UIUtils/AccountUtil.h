//
//  AccountUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/2.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountUtil : NSObject

+ (NSString *) getAccountID;

+ (NSString *)getAccountID:(long long)accountID;

@end
