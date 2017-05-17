//
//  UserDocOperator.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDocOperator : NSObject

+ (UserDocOperator *)getInstance;

- (Boolean)loadUserLogin:(NSString *)aeid;
- (Boolean)loadGroupConfig:(NSString *)groupName;
- (Boolean)loadAccountStrategy:(long long)accountID;
- (Boolean)loadAccountStrategyWitAccountID:(long long)accountID aeid:(NSString *)aeid;
- (Boolean)loadMoneyAccount:(long long)accountID;
- (Boolean)loadTrade4CFD:(long long)accountID;
- (Boolean)loadOrder4CFD:(long long)accountID;

@end
