//
//  DocOperator.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created by Allone on 15/7/8.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocOperator : NSObject

+ (DocOperator *)getInstance;

- (Boolean)initDoc:(NSLocale *)local
    otherCfgKeyVec:(NSArray *)otherCfgKeyVec;
- (void)loadQuoteTable:(NSArray *)instNameVec;
- (Boolean)resetUserDoc;
- (Boolean)loadUserData:(NSString *)userName;
- (Boolean)loadAccountData:(long long)accountID;

@end
