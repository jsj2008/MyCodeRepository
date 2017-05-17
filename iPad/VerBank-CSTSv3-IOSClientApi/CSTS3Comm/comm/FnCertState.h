//
//  FnCertState.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface FnCertState : AbstractJsonData

jsonValueInterface(ReturnCode,      int)
jsonValueInterface(RequestID,       int)
jsonValueInterface(CaSerial,        NSString *)
jsonValueInterface(CaState,         int)
jsonValueInterface(Cn,              NSString *)
jsonValueInterface(BeginValidTime,  long long)
jsonValueInterface(EndValidTime,    long long)

@end
