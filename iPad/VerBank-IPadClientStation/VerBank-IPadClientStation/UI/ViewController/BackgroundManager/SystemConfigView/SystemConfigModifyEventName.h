//
//  SystemConfigModifyEventName.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/15.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

// 修改后 發送notification 通知需要 排序的 界面

extern  NSString *const SystemConfig_InstrumentArrayChanged;
extern  NSString *const SystemConfig_OpenSortChanged;
extern  NSString *const SystemConfig_OrderSortChanged;
extern  NSString *const SystemConfig_PositionSumSortChanged;
extern  NSString *const SystemConfig_UpDownTypeChanged;

@interface SystemConfigModifyEventName : NSObject

@end
