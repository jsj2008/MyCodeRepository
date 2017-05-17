//
//  IosLogic.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/22.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginResult.h"

@interface IosLogic : NSObject

+ (IosLogic *)  getInstance;

- (id)          init;

- (Boolean)     setAccount:(long long)account;

#pragma mark Parameters

@property Boolean isLive;
@property (nonatomic, strong) UIWindow *uiWindow;

- (void)        setUserName:(NSString *) userName
                       aeid:(NSString *)aeid
                   password:(NSString *) password;


#pragma mark Login/Logout

- (LoginResult *)         loginToServer;
- (LoginResult *)         loginWithUserName:(NSString *) userName
                                       aied:(NSString *)aeid
                                   password:(NSString *) password
                                     isLive:(Boolean)isLive;
- (void)            logoutFromServer;

#pragma mark UIManager

- (Boolean)         gotoLoginViewController;
- (Boolean)         gotoMainViewController;

@end
