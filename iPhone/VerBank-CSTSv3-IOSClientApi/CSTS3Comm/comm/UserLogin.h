//
//  UserLogin.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface UserLogin : AbstractJsonData
jsonValueInterface(Aeid,NSString*)
jsonValueInterface(Type, int)
jsonValueInterface(RealName,NSString*)
jsonValueInterface(UserName,NSString*)
jsonValueInterface(CallEmail,NSString*)
jsonValueInterface(CallPhone,NSString*)
jsonValueInterface(MarginCallWay, int)
jsonValueInterface(Reckoning, int)
jsonValueInterface(ReckoningType, int)
jsonValueInterface(Disabled, int)

jsonValueInterface(IpFixed, int)
jsonValueInterface(IpList,NSString*)
jsonValueInterface(RegestTime ,NSDate*)
jsonValueInterface(RegestDealer,NSString*)
jsonValueInterface(ExpireDate,NSDate*)
jsonValueInterface(MessageRecType,NSString*)
jsonValueInterface(MsgLocal,NSString*)
jsonValueInterface(FirstLoginTime,NSDate*)
jsonValueInterface(LastLoginTime,NSDate*)

jsonValueInterface(MaxTradeAmount,double)
jsonValueInterface(StmntLang,int)
jsonValueInterface(StmntFreq,int)
jsonValueInterface(DlyStmntMail ,int)
jsonValueInterface(PeriodStmntMail ,int)
jsonValueInterface(CnfrmMail ,int)
jsonValueInterface(StmntOpenPsln ,int)
jsonValueInterface(SecretUser ,int)

jsonValueInterface(CaDownloadNumber ,int)
jsonValueInterface(CaLimitNumber ,int)

@end
