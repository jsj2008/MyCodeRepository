//
//  OP_Ctrl5103.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "OPFather.h"

@interface OP_Ctrl5103 : OPFather

jsonValueInterface(ReturnCode,  int)
jsonValueInterface(PreviousCA,  NSString *)

@end