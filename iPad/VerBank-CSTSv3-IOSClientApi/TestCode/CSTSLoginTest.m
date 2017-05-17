//
//  CSTSLoginTest.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/22/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "CSTSLoginTest.h"
#import "JEDISystem.h"
#import "ClientAPI.h"

@implementation CSTSLoginTest

- (id)      init
{
    self = [super init];
    
    if(self != nil)
    {
        userName = @"wangyubo";
        userPassword = @"Wangyubo168";
        accountBasicArray = nil;
    }
    
    return self;
}

- (void)    test
{
    [JEDISystem log:@"*************************************************************"];
    [JEDISystem log:@"Login Test start..."];
    
    [self preper];
    
    if(![self initTest]){
        [JEDISystem log:@"initTest failed."];
        return;
    }
    
    if(![self login]){
        [JEDISystem log:@"login failed."];
        return;
    }
    
    if(![self initDoc]){
        [JEDISystem log:@"initDoc failed."];
        return;
    }
    
    [JEDISystem log:@"*************************************************************"];
    [JEDISystem log:@"Login Test End"];
}

- (void)    preper
{
    [ClientAPI prepareAddressCaptain4XML:@"config/login"];
}

- (BOOL)    initTest
{
    JEDI_SYS_Try
    {
        //        [[ClientAPI getInstance] prepareCSTSList:true
        //                                        userName:userName
        //                                        password:userPassword
        //                                   byCSTSManager:false
        //                                     forResearch:false];
        [[ClientAPI getInstance] prepareCSTSList:true
                                            aeid:@"A123456701"
                                        password:userPassword
                                        userName:userName
                                         version:@"U.1.140905"];
        return true;
    }
    JEDI_SYS_EndTry
    
    return false;
}

- (BOOL)    login
{
    JEDI_SYS_Try
    {
        //        int nResult = [[ClientAPI getInstance] loginToBestAddress];
        LoginResult *nResult = [[ClientAPI getInstance] loginToBestAddress];
        if([nResult result] != USERIDENTIFY_RESULT_SUCCEED){
            return false;
        }
        
        accountBasicArray = [nResult accountBasicArray];
        
        NSString * logInfo = [NSString stringWithFormat:@"LOGIN (%d) to ---------> %@ : %d", [nResult result],
                              [[ClientAPI getInstance] getCurrentAddress].strIp,
                              [[ClientAPI getInstance] getCurrentAddress].nPort];
        
        [JEDISystem log:logInfo];
        return true;
    }
    JEDI_SYS_EndTry
    
    return false;
}

- (BOOL)    initDoc
{
    JEDI_SYS_Try
    {
        //        NSLocale * nsLocale = [[NSLocale alloc] initWithLocaleIdentifier:NSChineseCalendar];
        NSLocale * nsLocale = [[NSLocale alloc] initWithLocaleIdentifier:NSCalendarIdentifierChinese];
        NSMutableArray * mutArray = [[NSMutableArray alloc] init];
        
        //        return [[ClientAPI getInstance] initDoc:nsLocale clientCfgKeys:mutArray];
        return [[ClientAPI getInstance] initDoc:nsLocale clientCfgKeys:mutArray accountID:[[accountBasicArray objectAtIndex:0] getAccount]];
    }
    JEDI_SYS_EndTry
    
    return false;
}

@end
