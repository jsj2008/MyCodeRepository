//
//  CSTSManager.m
//  IOSClientStation
//
//  Created by felix on 9/4/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "CSTSManager.h"
#import "JEDISystem.h"
#import "JEDIDataRW.h"

BOOL  gsIsCSTSManagerNetworkOk;

@implementation CSTSManager

//------------------------------------------------------------------------------------------------
+ (NSMutableArray *) addressNodesFromManagers:(NSArray *) mgrNodes userName:(NSString *) userName
{
    if(mgrNodes == nil || mgrNodes.count == 0 || userName == nil){
        return nil;
    }
    
    JEDI_SYS_Try
    {
        CSTSManager * cstsMgr = [[CSTSManager alloc] initWithNodes:mgrNodes];
        return [cstsMgr queryAddresses:userName];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//------------------------------------------------------------------------------------------------
+ (BOOL)    isNetworkOk
{
    return gsIsCSTSManagerNetworkOk;
}

//------------------------------------------------------------------------------------------------
- (id) initWithNodes:(NSArray *) mgrNodes
{
    self = [super init];
    
    if(self != nil)
    {
        mProxyArray = nil;
        mCSTSNodes = nil;
        mMgrNodes = [[NSMutableArray alloc] initWithArray:mgrNodes];
    }
    
    return self;
}

//------------------------------------------------------------------------------------------------
- (void) dealloc
{
    if(mProxyArray){
        [mProxyArray removeAllObjects];
    }
    
    if(mMgrNodes){
        [mMgrNodes removeAllObjects];
    }
    
    mProxyArray = nil;
    mMgrNodes = nil;
    mCSTSNodes = nil;
}

//------------------------------------------------------------------------------------------------
- (NSMutableArray *) queryAddresses:(NSString *) userName
{
    gsIsCSTSManagerNetworkOk = NO;
    AddressNode * node = nil;
    CSTSMgrProxy * cstsProxy = nil;
    
    if(mCSTSNodes != nil){
        [mCSTSNodes removeAllObjects];
    }
    
    if(mProxyArray == nil){
        mProxyArray = [[NSMutableArray alloc] init];
    }
    
    for(int i=0; i<mMgrNodes.count; ++i)
    {
        node = [mMgrNodes objectAtIndex:i];
        cstsProxy = [[CSTSMgrProxy alloc] initWithNode:node userName:userName andDelegate:self];
        
        [mProxyArray addObject:cstsProxy];
        [cstsProxy startQuery];
    }
    
    int nIndex = 0;
    int nSize = 30;
    
    while(nIndex++ < nSize)
    {
        @synchronized(mProxyArray)
        {
            if(mProxyArray.count == 0){
                break;
            }
            
            if(mCSTSNodes != nil && mCSTSNodes.count > 0){
                break;
            }
        }
        
        [NSThread sleepForTimeInterval:1.0];
    }
    
    @synchronized(mProxyArray)
    {
        for(int i=0; i<mProxyArray.count; i++){
            cstsProxy = [mProxyArray objectAtIndex:i];
            [cstsProxy stopQuery];
        }
    }
    
    return mCSTSNodes;
}

//------------------------------------------------------------------------------------------------
- (void)    didQueryFromServer:(NSMutableArray *) nodeArray cstsProxy:(id)proxy
{
    @synchronized(mProxyArray)
    {
        [mProxyArray removeObject:proxy];
        if(proxy != nil){
            CSTSMgrProxy * mgrProxy = proxy;
            gsIsCSTSManagerNetworkOk = gsIsCSTSManagerNetworkOk || [mgrProxy isNetworkOk];
        }
        
        if(nodeArray == nil || nodeArray.count == 0){
            return;
        }
        
        if(mCSTSNodes == nil){
            mCSTSNodes = [[NSMutableArray alloc] init];
        }
        
        [mCSTSNodes addObjectsFromArray:nodeArray];
    }
}

@end
