//
//  IosLogic.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginResult.h"
#import "ScreenAuotoSizeScale.h"
#import "DataCenter.h"
@interface IosLogic : NSObject

+ (IosLogic *)  getInstance;

- (id)          init;

- (Boolean)     setAccount:(long long)account;

#pragma mark Parameters

@property Boolean isLive;

- (void)        setWindow:(UIWindow *) window;
- (void)        setUserName:(NSString *) userName aeid:(NSString *)aeid password:(NSString *) password;
- (UIWindow *)  getWindow;

#pragma mark Login/Logout

- (LoginResult *)         loginToServer;
- (LoginResult *)         loginWithUserName:(NSString *) userName
                                       aied:(NSString *)aeid
                                   password:(NSString *) password
                                     isLive:(Boolean)isLive;
- (void)        logoutFromServer;

#pragma mark UIManager

- (Boolean)         gotoLoginViewController;
- (Boolean)         gotoMainViewController;
- (Boolean)         gotoQuoteListViewController;
- (Boolean)         gotoOpenPositionViewController;
- (Boolean)         gotoClosePositionViewController;
- (Boolean)         gotoPositionSumViewController;
- (Boolean)         gotoOrderHisViewController;
- (Boolean)         gotoOrderPositionViewController;
- (Boolean)         gotoMarketTradeViewController;
- (Boolean)         gotoHedgingViewController;
- (Boolean)         gotoOrderAddOrModifyViewController;
- (Boolean)         gotoPriceWarningViewController;
- (Boolean)         gotoMessageViewController;
- (Boolean)         gotoForexNewsViewController;
- (Boolean)         gotoReviewViewController;
- (Boolean)         gotoOrderOpenAddOrModifyViewController;
- (Boolean)         gotoSystemConfigViewController;
- (Boolean)         gotoAbountViewController;
- (Boolean)         gotoMarginCallHisViewController;


- (Boolean)         gotoPriceWarningAddOrModifyViewController;

- (Boolean)         gotoTest;

- (Boolean)         gotoChooseViewController:(int)chooseType chooseArray:(NSArray *)array;

@end
