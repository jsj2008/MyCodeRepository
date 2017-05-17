//
//  JEDISecret.h
//  JEDI-IOSClientApi-Socket
//
//  Created by felix on 7/11/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <openssl/rsa.h>

@interface JEDISecret : NSObject

+ (JEDISecret *) defaultSecret;

- (id)          init;

- (NSString *)  getRSAPublicKey;
- (BOOL)        setAESKeyWithData:(NSData *) nsData;

- (NSData *)    encryptDataWithAES:(NSData *) nsData;
- (NSData *)    decryptDataWithAES:(NSData *) nsData;

- (NSData *)    encryptDataWithRSA:(NSString *) nsStr;
- (NSData *)    decryptDataWithRSA:(NSData *) nsData;

@end
