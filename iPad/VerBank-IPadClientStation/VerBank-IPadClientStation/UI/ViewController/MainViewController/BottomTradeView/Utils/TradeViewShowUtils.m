//
//  TradeViewShowUtils.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/3/9.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "TradeViewShowUtils.h"
#import "MTP4CommDataInterface.h"
#import "LangCaptain.h"

@implementation TradeViewShowUtils

+ (NSString *)getStringByBuySell:(int)buySell {
    return buySell == BUY ? [[LangCaptain getInstance] getLangByCode:@"Buy"] : [[LangCaptain getInstance] getLangByCode:@"Sell"];
}

@end
