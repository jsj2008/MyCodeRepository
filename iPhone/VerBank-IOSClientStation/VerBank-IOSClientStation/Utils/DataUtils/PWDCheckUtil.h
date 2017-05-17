//
//  PWDCheckUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWDCheckUtil : NSObject

+ (Boolean)isPwdLegal:(NSString *)pwd accountID:(NSString *)accountID;

@end
