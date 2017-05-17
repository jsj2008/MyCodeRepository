//
//  FnStatus.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "AbstractJsonData.h"

@interface FnStatus : AbstractJsonData

jsonValueInterface(ReturnCode,          int)
jsonValueInterface(ReturnMessage,       int)
jsonValueInterface(EffectiveCANumber,   int)
jsonValueInterface(RequestCANumber,     int)
jsonValueInterface(LastCASerial,        NSString *)
jsonValueInterface(LastCAState,         int)
jsonValueInterface(CsrLength,           int)
jsonValueInterface(PreviousCA,          NSString *)

@end
