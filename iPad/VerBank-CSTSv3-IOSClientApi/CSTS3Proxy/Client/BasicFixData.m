//
//  BasicFixData.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "BasicFixData.h"

@implementation BasicFixData

@synthesize dataType = mDataType;
@synthesize isEncrypt = mIsEncrypt;
@synthesize isZip = mIsZip;

//-----------------------------------------------
- (id) init
{
    self = [super init];
    
    if(self != nil)
    {
        self.dataType = FI_DATATYPE_JSON;
        self.isEncrypt = NO;
        self.isZip = NO;
        
        mFixData = nil;
    }
    
    return self;
}

//-----------------------------------------------
- (id) initWithType:(UInt16) type
{
    self = [super init];
    
    if(self != nil)
    {
        self.dataType = type;
        self.isEncrypt = NO;
        self.isZip = NO;
        
        mFixData = nil;
    }
    
    return self;
}

//-----------------------------------------------
- (void) dealloc
{
    mFixData = nil;
}

//-----------------------------------------------
- (NSData *)    getData
{
    return mFixData;
}

//-----------------------------------------------
- (void)        setData:(NSData *) data
{
    mFixData = data;
}

#pragma mark Abstract functions

//-----------------------------------------------
- (NSData *)    format
{
    return nil;
}

//-----------------------------------------------
- (BOOL)        parse
{
    return NO;
}

@end
