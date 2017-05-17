//
//  CertificateSaveData.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/19.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CertificateSaveData : NSObject

+ (CertificateSaveData *)getInstance;

- (void)saveConfigData;

@property NSString *GUID;

- (char *)getUserPin;
- (void)setUserPin:(char *)userPin;

- (char *)getCN;
- (void)setCN:(char *)cn;

- (char *)getCsr;
- (void)setCsr:(char *)csr;

- (char *)getKeySet;
- (void)setKeySet:(char *)keySet;

- (char *)getKeySetData;
- (void)setKeySetData:(char *)keySetData;

- (void)destroy;

@end
