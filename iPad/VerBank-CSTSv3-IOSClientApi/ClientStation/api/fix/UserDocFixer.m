//
//  UserDocFixer.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "UserDocFixer.h"
#import "JEDISystem.h"
#import "CDS_AccountStore.h"
#import "APIDoc.h"
#import "ClientAPI.h"

@interface UserDocFixer ()
{
@private
    Boolean     mIsDestroy;
    NSThread    * mFixerThread;
}

-(void)     runFixAccounts;
-(void)     fixAccounts;

@end


//------------------------------------------------
@implementation UserDocFixer

-(id)   init
{
    self = [super init];
    
    if(self !=  nil)
    {
        mFixerThread = nil;
        mIsDestroy = false;
    }
    
    return self;
}

-(void) start
{
    if(mFixerThread == nil){
        mFixerThread = [[NSThread alloc] initWithTarget:self selector:@selector(runFixAccounts) object:nil];
    }
    
    if(mFixerThread != nil){
        [mFixerThread start];
    }
}

-(void) destroy
{
    mIsDestroy = true;
    
    if(mFixerThread != nil){
        [mFixerThread cancel];
    }
    
    mFixerThread = nil;
}


-(void) runFixAccounts{
    while (!mIsDestroy){
        if (mIsDestroy) {
            return ;
        }
        
        [self fixAccounts];
        
        JEDI_SYS_Try{
            [NSThread sleepForTimeInterval:0.25];
        }
        JEDI_SYS_EndTry
    }
}

-(void)fixAccounts{
    NSArray *array = [[APIDoc getUserDocCaptain] getCDS_AccountStoreArray];
    for (CDS_AccountStore *as in array) {
        if ([as getAccountID] == [[ClientAPI getInstance] accountID]) {
            @try {
                [[APIDoc getFixUtil] fixAccount:as  ForceToScanTrde:true];
            }
            @catch (NSException *exception) {
                NSLog(@"FIX EXCEPTION ... %@",exception);
                NSLog(@"%@ %@", [exception name], [exception reason]);
            }
        }
    }
}

@end
