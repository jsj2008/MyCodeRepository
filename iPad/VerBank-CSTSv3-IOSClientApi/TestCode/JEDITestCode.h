//
//  JEDITestCode.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/15/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDITestCode : NSObject

+ (void)    RSATestCode;
+ (void)    AESTestCode;
+ (void)    ZIPTestCode;

+ (void)    MD5TestCode;

+ (void)    JSONTestCode;

+ (void)    RSATestCodeOpenssl;

+ (void)    HandleServerData:(NSData *)nsData;

+ (void)    TestCSTSProxy;
+ (void)    TestCSTSLogin;

+ (void)    TestTimeInterval;

@end
