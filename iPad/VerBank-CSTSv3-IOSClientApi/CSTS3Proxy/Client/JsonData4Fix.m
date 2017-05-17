//
//  JsonData4Fix.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "JsonData4Fix.h"
#import "JEDISystem.h"
#import "JEDISecret.h"
#import "JEDIZip.h"
#import "JsonFactory.h"

@implementation JsonData4Fix

//--------------------------------------------------------------
- (id) init
{
    self = [super init];
    
    if(self != nil)
    {
        self.dataType = FI_DATATYPE_JSON;
        
        mJsonData = nil;
        mJsonString = nil;
    }
    
    return self;
}

//--------------------------------------------------------------
- (void) dealloc
{
    mJsonString = nil;
    mJsonData = nil;
}

//--------------------------------------------------------------
- (void) setJsonData:(AbstractJsonData *) data
{
    mJsonData = data;
}

//--------------------------------------------------------------
- (AbstractJsonData *) getJsonData
{
    return mJsonData;
}

//--------------------------------------------------------------
- (NSString *) getJsonString
{
    if(mJsonString == nil && mJsonData != nil){
        mJsonString = [mJsonData getJsonString];
    }
    
    return mJsonString;
}

#pragma mark Override

//--------------------------------------------------------------
- (NSData *) format
{
    JEDI_SYS_Try
    {
        NSOutputStream * opStream = [NSOutputStream outputStreamToMemory];
        if(opStream == nil){
            [JEDISystem log:@"JsonData4Fix.format, create opStream failed."];
            return nil;
        }
    
        NSData *dType = [JEDISystem dataFromInt:mDataType withLength:2];
        NSData *dZip  = [JEDISystem dataFromInt:mIsZip withLength:1];
        NSData *dEncrypt = [JEDISystem dataFromInt:mIsEncrypt withLength:1];
        
        [opStream open];
        [opStream write:(const UInt8*)[dType bytes] maxLength:2];
        [opStream write:(const UInt8*)[dZip bytes] maxLength:1];
        [opStream write:(const UInt8*)[dEncrypt bytes] maxLength:1];
        
        NSData* nsData = [mJsonData getJsonData];
        if(nsData != nil)
        {
            if(self.isEncrypt){
                nsData = [[JEDISecret defaultSecret] encryptDataWithAES:nsData];
            }
            if(self.isZip){
                nsData = [JEDIZip zipDataFromData:nsData];
            }
            
            [opStream write:[nsData bytes] maxLength:[nsData length]];
        }
        
        nsData = [opStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        
        [opStream close];
        return nsData;
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//--------------------------------------------------------------
- (BOOL)     parse
{
    JEDI_SYS_Try
    {
        if(mFixData == nil){
            return NO;
        }
        
        NSData * nsData = mFixData;
        
        if(self.isZip){
            nsData = [JEDIZip dataFromZipData:nsData];
        }
        
        if(self.isEncrypt){
            nsData = [[JEDISecret defaultSecret] decryptDataWithAES:nsData];
        }
        
        mJsonString = [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
        
        id objId = [JsonFactory parseWithJsonData:nsData];
        
        if(objId != nil && [objId isKindOfClass:[AbstractJsonData class]]){
            mJsonData = objId;
            return YES;
        }
    }
    JEDI_SYS_EndTry
    
    return NO;
}

@end
