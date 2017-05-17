//
//  TOrders4CFD.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "TOrders4CFD.h"
static NSString * jsonId = @"22";

static NSString * orderID = @"1";
static NSString * osplitNo = @"2";
static NSString * account = @"3";
static NSString * instrument = @"4";
static NSString * buysell = @"5";
static NSString * lots = @"6";
static NSString * type = @"7";
static NSString * limitPrice = @"8";
static NSString * isStopGuaranteed = @"9";
static NSString * oriStopPrice = @"10";
static NSString * currentStopPrice = @"11";
static NSString * stopMoveGap = @"12";
static NSString * marketPrice4Open = @"13";
static NSString * openTradeDay = @"14";
static NSString * openTime = @"15";
static NSString * isToOpenNew = @"16";
static NSString * toCloseTickets = @"17";
static NSString * marginPerc4Open = @"18";
static NSString * antiTickets = @"19";
static NSString * correspondingTicket = @"20";
static NSString * expiryTime = @"21";
static NSString * iFDLimitPrice = @"22";
static NSString * iFDStopPrice = @"23";
static NSString * IFDisStopGuaranteed = @"24";
static NSString * isPriceReached = @"25";
static NSString * priceReachTime = @"26";
static NSString * reachedPrice = @"27";
static NSString * priceReachedWay = @"28";
static NSString * openUserName = @"29";
static NSString * openUserIPAddress = @"30";
static NSString * openUserType = @"31";
static NSString * guaranteeStopCharge = @"32";
static NSString * guaranteeStopChargeCurrency = @"33";
static NSString * openGroup = @"34";
@implementation TOrders4CFD
- (id)init{
    self = [super init];
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}
@end
