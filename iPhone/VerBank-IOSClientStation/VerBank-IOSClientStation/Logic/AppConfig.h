//
//  AppConfig.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/30.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

+ (AppConfig *)getInstance;

- (void)saveConfigData;

@property NSString *GUID;
@property NSString *certificateContext;
//@property NSString *userPin;
//@property NSString *CN;
//@property NSString *csr;
//@property NSString *keySet;

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
