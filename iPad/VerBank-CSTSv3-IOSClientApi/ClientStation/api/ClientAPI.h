//
//  ClientAPI.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/16.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCaptain.h"
#import "AddressNode.h"
#import "UserDocFixer.h"
#import "APIReConnectOperator.h"
#import "API_IDEventCaptain.h"
#import "CSTSCaptain.h"
//#import "DocOperator.h"
//#import "IP_TRADESERV5001.h"
//#import "OP_TRADESERV5001.h"
#import "LoginResult.h"


//-------------------------------------------------------------------------
//
//
//-------------------------------------------------------------------------

@interface ClientAPI : NSObject

@property UserDocFixer *userDocFixer;
@property NSString *aeid;
@property NSString *userName;
@property NSString *version;
@property NSString *crypyPassword;
@property long long accountID;
@property AddressCaptain *addressCaptain;
@property AddressNode *currentAddress;
@property Boolean isFirstLogin;
@property long long firstLoginTime;
@property Boolean docInited;
@property APIReConnectOperator *connectOperator;
@property NSMutableArray *accounts;




//------------------------------------------------------------------------------------------------------
#pragma mark static functions
//------------------------------------------------------------------------------------------------------

+ (ClientAPI *)         getInstance;

+ (BOOL)                prepareAddressCaptain4XML:(NSString *)xml;

//+ (NSMutableArray *)    getSocks5ProxyList;
//+ (void)                setSocks5Proxy:(SockProxyNode *)proxy;
//+ (void)                removeSocks5Proxy;

+ (NSString *)          getUserName;

//------------------------------------------------------------------------------------------------------
- (id)                  init;

- (void)                prepareCSTSList:(Boolean)isLive
                                   aeid:(NSString *)aeid
                               password:(NSString *)password
                               userName:(NSString *)userName
                                version:(NSString *)version;

- (void)resetPassword:(NSString *)password;

- (LoginResult *)                 loginToBestAddress;

- (void)                requestToReLogin;
- (NSMutableArray *)    getAddressList;

- (Boolean)             initDoc:(NSLocale *)locale
                  clientCfgKeys:(NSMutableArray *)clientCfgKeys
                      accountID:(long long)accountID;

- (Boolean)             isNetOK;

- (void)                destroy;

- (AddressNode *)       getCurrentAddress;
- (AddressCaptain *)    getAddressCaptain;



- (NSMutableArray *)    getAccounts;
//- (long long)           getAccount;

//------------------------------------------------------------------------------------------------------
- (LoginResult *)                 login:(AddressNode *)addressNode;
- (LoginResult *)                 _doLogin:(NSString *)aeid
                          encryptedPasswod:(NSString *)encryptedPassword
                                  userName:(NSString *)userName
                                   version:(NSString *)version;

+ (NSString *)          encryptAllone:(NSString *)password key:(NSString *) key;

@end
