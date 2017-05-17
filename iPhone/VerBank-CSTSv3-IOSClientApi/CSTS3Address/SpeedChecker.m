//
//  SpeedChecker.m
//  IOSClientStation
//
//  Created by felix on 8/8/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "SpeedChecker.h"
#import "JEDIDateTime.h"
#import "JEDISystem.h"

//----------------------------------------------------------------------
@interface SpeedChecker ()
{
    NSMutableArray * mCheckedNodeArray;
    NSMutableArray * mCheckerArray;
    
    int       mCheckSize;
    int       mCheckedSize;
}

@end


//----------------------------------------------------------------------
@implementation SpeedChecker

//----------------------------------------------------------------------
- (id)  init
{
    self = [super init];
    if(self != nil)
    {
        mCheckedNodeArray = nil;
        mCheckerArray = nil;
        
        mCheckedSize = 0;
        mCheckSize = 0;
    }
    return self;
}

- (void) dealloc
{
    [mCheckedNodeArray removeAllObjects];
    mCheckedNodeArray = nil;
    
    [mCheckerArray removeAllObjects];
    mCheckerArray = nil;
}

//----------------------------------------------------------------------
- (void)checkSpeed:(NSArray *) nodeArray
{
    mCheckedSize = 0;
    mCheckSize = 0;
    
    if(nodeArray == nil || nodeArray.count <= 1){
        return;
    }
    
    JEDI_SYS_Try
    {
        //
        // init array for speed checker
        //
        if(mCheckerArray == nil){
            mCheckerArray = [[NSMutableArray alloc] init];
        }else{
            [mCheckerArray removeAllObjects];
        }
        
        if(mCheckedNodeArray == nil){
            mCheckedNodeArray = [[NSMutableArray alloc] init];
        }else{
            [mCheckedNodeArray removeAllObjects];
        }
        
        //
        // create checker
        //
        for(int i=0; i<nodeArray.count; i++)
        {
            AddressChecker * checker = [[AddressChecker alloc] initWithNode:[nodeArray objectAtIndex:i]
                                                                andDelegate:self];
            
            mCheckSize ++;
            
            [mCheckerArray addObject:checker];
            [checker startChecking];
        }
    }
    JEDI_SYS_EndTry
    
    [self waitCheckFinished];
}

//----------------------------------------------------------------------
- (void) waitCheckFinished
{
    int nTotalTimes = 50;
    
    while(mCheckedSize < mCheckSize)
    {
        [NSThread sleepForTimeInterval:0.5]; // 100 ms
        
        nTotalTimes -- ;

        if(nTotalTimes <= 0 || [self hasGoodAddress])
        {
            for(AddressChecker * checker in mCheckerArray){
                [checker stopChecking];
            }
            
            [JEDISystem log:@"SpeedChecker.checkSpeec --> some check don't finised."];
            break;
        }
    }
    
    [mCheckerArray removeAllObjects];
    [mCheckedNodeArray removeAllObjects];
    
    mCheckerArray = nil;
    mCheckedNodeArray = nil;
}

//----------------------------------------------------------------------
- (BOOL)hasGoodAddress
{
    @synchronized(mCheckedNodeArray)
    {
        if(mCheckedNodeArray.count == 0) return NO;
        
        for(AddressNode * node in mCheckedNodeArray){
            if([node isGood]) return YES;
        }
    }
    
    return NO;
}

//----------------------------------------------------------------------
- (void)didAddressCheck:(AddressNode *) node
{
    mCheckedSize ++;
    
    @synchronized(mCheckedNodeArray)
    {
        [mCheckedNodeArray addObject:node];
    }
}

@end
