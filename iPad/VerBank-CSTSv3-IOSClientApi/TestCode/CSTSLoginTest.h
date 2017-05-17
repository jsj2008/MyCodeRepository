//
//  CSTSLoginTest.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/22/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTSLoginTest : NSObject
{
@private
    NSString * userName;
    NSString * userPassword;
    NSArray *accountBasicArray;
}

- (id)      init;

- (void)    test;

- (void)    preper;
- (BOOL)    initTest;
- (BOOL)    login;
- (BOOL)    initDoc;

@end
