//
//  Info_TRADESERV1004.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoFather.h"

static int ATTRID_SYSTEMCONFIG = 0;
static int ATTRID_INSTRUMENT = 1;
static int ATTRID_HOLIDAY = 4;
static int ATTRID_GROUPCONFIG = 6;
static int ATTRID_INSTRUMENTDEAD = 9;
static int ATTRID_GROUPDELETE = 13;

static int ATTRID_INTERESTRATE = 2;
static int ATTRID_INTERESTADDTYPE = 3;
static int ATTRID_NOVALUEDAY4INST = 5;

static int ATTRID_BASICCURRENCY = 8;

@interface Info_TRADESERV1004 : InfoFather

jsonValueInterface(ChangedAttrID,   int)
jsonValueInterface(AttriName,       NSString *)

@end
