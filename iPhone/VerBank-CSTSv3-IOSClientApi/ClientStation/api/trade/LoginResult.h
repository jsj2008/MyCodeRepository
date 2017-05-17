//
//  LoginResult.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountBasic.h"
#import "MTP4CommDataInterface.h"

@interface LoginResult : NSObject

@property int result;
@property Boolean passwordNeedChange;
@property Boolean userNameNeedChange;
@property NSArray *accountBasicArray;

@end
