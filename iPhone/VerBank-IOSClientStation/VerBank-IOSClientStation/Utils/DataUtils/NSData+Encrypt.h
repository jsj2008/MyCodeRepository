//
//  NSData+Encrypt.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/11/15.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
@end
