//
//  InfoOperator_TRADESERV1004.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "InfoOperator_TRADESERV1004.h"
#import "Info_TRADESERV1004.h"
#import "JEDISystem.h"

#import "InstrumentDocOperator.h"
#import "UserDocOperator.h"
#import "SystemDocOperator.h"
#import "MTP4CommDataInterface.h"

#import "APIDoc.h"

#define info_TS1004_ATTRID_SYSTEMCONFIG     0
#define info_TS1004_ATTRID_INSTRUMENT       1
#define info_TS1004_ATTRID_TRADETYPE        2
#define info_TS1004_ATTRID_ROLLOVER         3
#define info_TS1004_ATTRID_HOLIDAY          4
#define info_TS1004_ATTRID_BATCHRATEGAP     5
#define info_TS1004_ATTRID_GROUPCONFIG      6
#define info_TS1004_ATTRID_INSTRUMENTTYPE   7
#define info_TS1004_ATTRID_BASICCURRENCY    8
#define info_TS1004_ATTRID_INSTRUMENTDEAD   9
#define info_TS1004_ATTRID_IBCHARGESTRATEGY 10
#define info_TS1004_ATTRID_ABNORMALTRADECHECKCONFIG 11
#define info_TS1004_ATTRID_TRADECTRLSTRATEGY 12
#define info_TS1004_ATTRID_GROUPDELETE      13

@implementation InfoOperator_TRADESERV1004

- (void) onInfo:(InfoFather *)info {
    
    Info_TRADESERV1004 * tinfo = (Info_TRADESERV1004 *)info;
    int attrID = [tinfo getChangedAttrID];
    
    switch (attrID) {
            
        case info_TS1004_ATTRID_GROUPCONFIG:
            if([[APIDoc getUserDocCaptain] getGroupDoc:[tinfo getAttriName]] != nil){
                [[UserDocOperator getInstance] loadGroupConfig:[tinfo getAttriName]];
            }
            break;
            
        case info_TS1004_ATTRID_HOLIDAY:
            break;
            
        case info_TS1004_ATTRID_INSTRUMENT:
            if([tinfo getAttriName] == nil){
                [[InstrumentDocOperator getInstance] loadInstruments];
            }else{
                [[InstrumentDocOperator getInstance] loadInstruments:[tinfo getAttriName]];
            }
            break;
            
        case info_TS1004_ATTRID_SYSTEMCONFIG:
            [[SystemDocOperator getInstance] loadSystemConfig];
            break;
            
        case info_TS1004_ATTRID_INSTRUMENTDEAD:
            break;
            
        default:
            break;
    }
    
}


@end
