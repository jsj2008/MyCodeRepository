//
//  ClosePositionDetails.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/29.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TSettled.h"

@interface ClosePositionDetails : TSettled

jsonValueInterface(Aeid, NSString *)
jsonValueInterface(OpenRuleType, int)
jsonValueInterface(OpenIpAddress, NSString *)
jsonValueInterface(CloseRuleType, int)
jsonValueInterface(CloseName, NSString *)
jsonValueInterface(CloseIpAddress, NSString *)

@property NSString *sortTag;
@property Boolean isSelected;

- (double)getProfit;

@end
