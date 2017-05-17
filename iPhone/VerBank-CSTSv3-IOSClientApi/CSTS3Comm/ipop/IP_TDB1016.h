//
//  IP_TDB1016.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/27.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IPFather.h"

static int TDB1016_TYPE_ALL = 0;
static int TDB1016_TYPE_ACCOUNT = 1;
static int TDB1016_TYPE_TICKET = 2;
static int TDB1016_TYPE_TICKET_AND_SPLITNO = 3;
static int TDB1016_TYPE_GROUPVEC = 4;

static int RAG_TYPE_ALL = 0;
static int RAG_TYPE_TDATE = 1;
static int RAG_TYPE_SDATE = 2;
static int RAG_TYPE_OPENTRADEDAY = 3;
static int RAG_TYPE_CLOSETRADEDAY = 4;

@interface IP_TDB1016 : IPFather

jsonValueInterface(ConditionType,   int)
jsonValueInterface(TimeRagType,     int)
jsonValueInterface(TimeFrom,        NSDate *)
jsonValueInterface(TimeTo,          NSDate *)
jsonValueInterface(FromDay,         NSString *)
jsonValueInterface(EndDay,          NSString *)
jsonValueInterface(GroupVec,        NSArray *)
jsonValueInterface(Account,         long long)
jsonValueInterface(Ticket,          long long)
jsonValueInterface(Splitno,         int)

@end
