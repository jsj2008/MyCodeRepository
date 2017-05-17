//
//  BasicFixData.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

//--------------------------------------------------------
#ifndef  JEDI_FIX_COMM_INTERFACE
#define  JEDI_FIX_COMM_INTERFACE

enum FixcommInterface
{
    FI_DATATYPE_ECHO    = 0,
    FI_DATATYPE_BYTE    = 1,
    FI_DATATYPE_JSON    = 2,
    FI_DATATYPE_OBJECT  = 3,
};

#define  FMS_LENGTH_HEADER  8
#define  FMS_LENGTH_MSINFO  4

#endif


//--------------------------------------------------------
@interface BasicFixData : NSObject
{
@protected
    NSData * mFixData;
    
    UInt16   mDataType;
    BOOL     mIsZip;
    BOOL     mIsEncrypt;
}

@property (nonatomic) UInt16 dataType;
@property (nonatomic) BOOL   isZip;
@property (nonatomic) BOOL   isEncrypt;


- (id) init;
- (id) initWithType:(UInt16) type;

- (NSData *)    getData;
- (void)        setData:(NSData *) data;

#pragma mark Abstract functions

- (NSData *)    format;
- (BOOL)        parse;

@end
