//
//  TradeServiceErrCodeTable.h
//  VerBank-IOSClienextern  NSString *const TStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All righextern  NSString *const TS reserved.
//

#import "IPOPErrCodeTable.h"

extern  NSString *const TS_ERR_AccountNotFound;
extern  NSString *const TS_ERR_TradeDisabled;
extern  NSString *const TS_ERR_System_is_Close;
extern  NSString *const TS_ERR_GroupNotFound;
extern  NSString *const TS_ERR_MD5DigestDontMatch;
extern  NSString *const TS_ERR_InstrumentNotValid;
extern  NSString *const TS_ERR_Amount_times;
extern  NSString *const TS_ERR_Amount_limit_by_USD;
extern  NSString *const TS_ERR_Amount_Zero;
extern  NSString *const TS_ERR_Amount_Match;
extern  NSString *const TS_ERR_Trade_Param;
extern  NSString *const TS_ERR_Price;
extern  NSString *const TS_ERR_ExpireTime;
extern  NSString *const TS_ERR_Amount_Max_by_USD;
extern  NSString *const TS_ERR_Cut_Loss_Account;
extern  NSString *const TS_ERR_Cut_Loss_User;
extern  NSString *const TS_ERR_MarginNotEnough_UnLock;
extern  NSString *const TS_ERR_MarginNotEnough_Trade;
extern  NSString *const TS_ERR_Sumbmiter_type;
extern  NSString *const TS_ERR_OrderType;
extern  NSString *const TS_ERR_FixOrderCheck;
extern  NSString *const TS_ERR_OrderNotFound;
extern  NSString *const TS_ERR_NoUptradeOrder;
extern  NSString *const TS_ERR_OrderPriceReach;
extern  NSString *const TS_ERR_NetTrade_locked;
extern  NSString *const TS_ERR_QueryNewIDFailed;
extern  NSString *const TS_ERR_Accountisbusy;
extern  NSString *const TS_ERR_Exception;
extern  NSString *const TS_ERR_Other;
extern  NSString *const TS_ERR_Uptrade;
extern  NSString *const TS_ERR_BackDateTrade_DateError;
extern  NSString *const TS_ERR_BackDateTrade_Disabled;

extern  NSString *const UT_ERR_Quote;
extern  NSString *const UT_ERR_Price;
extern  NSString *const UT_ERR_UptradeDB;
extern  NSString *const UT_ERR_Uptrade_timeout;
extern  NSString *const UT_ERR_Uptrade_Faild;
extern  NSString *const UT_ERR_NetError;

@interface TradeServiceErrCodeTable : IPOPErrCodeTable

@end
