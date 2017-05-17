//
//  OP_Ctrl1001.h
//  IOSClientStation_ex02
//
//  Created by Allone on 15/6/23.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"

@interface OP_Ctrl1001 : OPFather
-(id)       init;

jsonValueInterface(Result,              int)
jsonValueInterface(LoginTime,           long long)
jsonValueInterface(FixedIPVector,       NSMutableArray *)
jsonValueInterface(PasswordNeedChange,  Boolean)
jsonValueInterface(UserNameNeedChange,  Boolean)
jsonValueInterface(AccountList,         NSMutableArray *)
jsonValueInterface(CertState,           int)
jsonValueInterface(CersStateDesc,       NSString *)

@end
