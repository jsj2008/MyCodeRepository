//
//  UserLogin.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "UserLogin.h"
static NSString * jsonId = @"UserLogin";

static NSString * aeid = @"1";
static NSString * type = @"2";
static NSString * realName = @"3";
static NSString * userName = @"4";
static NSString * callEmail = @"5";
static NSString * callPhone = @"6";
static NSString * marginCallWay = @"7";
static NSString * reckoning = @"8";
static NSString * reckoningType = @"9";
static NSString * disabled = @"10";

static NSString * ipFixed = @"11";
static NSString * ipList = @"12";
static NSString * regestTime = @"13";
static NSString * regestDealer = @"14";
static NSString * expireDate = @"15";
static NSString * messageRecType = @"16";
static NSString * msgLocal = @"17";
static NSString * firstLoginTime = @"18";
static NSString * lastLoginTime = @"19";

static NSString * maxTradeAmount = @"20";
static NSString * StmntLang = @"21";
static NSString * StmntFreq = @"22";
static NSString * DlyStmntMail = @"23";
static NSString * PeriodStmntMail = @"24";
static NSString * CnfrmMail = @"25";
static NSString * StmntOpenPsln = @"26";
static NSString * secretUser = @"27";
static NSString * caDownloadNumber = @"28";
static NSString * caLimitNumber = @"29";

@implementation UserLogin
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString(Aeid,        aeid)
jsonImplementionInt(Type,           type)
jsonImplementionString(RealName,    realName)
jsonImplementionString(UserName,    userName)
jsonImplementionString(CallEmail,   callEmail)
jsonImplementionString(CallPhone,   callPhone)
jsonImplementionInt(MarginCallWay,  marginCallWay)
jsonImplementionInt(Reckoning,      reckoning)
jsonImplementionInt(ReckoningType,  reckoningType)
jsonImplementionInt(Disabled,       disabled)

jsonImplementionInt(IpFixed,        ipFixed)
jsonImplementionString(IpList,      ipList)
jsonImplementionDate(RegestTime ,   regestTime)
jsonImplementionString(RegestDealer,regestDealer)
jsonImplementionDate(ExpireDate,    expireDate)
jsonImplementionString(MessageRecType,messageRecType)
jsonImplementionString(MsgLocal,    msgLocal)
jsonImplementionDate(FirstLoginTime,firstLoginTime)
jsonImplementionDate(LastLoginTime, lastLoginTime)

jsonImplementionDouble(MaxTradeAmount,  maxTradeAmount)
jsonImplementionInt(StmntLang,          StmntLang)
jsonImplementionInt(StmntFreq,          StmntFreq)
jsonImplementionInt(DlyStmntMail ,      DlyStmntMail)
jsonImplementionInt(PeriodStmntMail ,   PeriodStmntMail)
jsonImplementionInt(CnfrmMail ,         CnfrmMail)
jsonImplementionInt(StmntOpenPsln ,     StmntOpenPsln)
jsonImplementionInt(SecretUser ,        secretUser)

jsonImplementionInt(CaDownloadNumber ,  caDownloadNumber)
jsonImplementionInt(CaLimitNumber,      caLimitNumber)

@end
