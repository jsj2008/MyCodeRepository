//
//  QuoteSizeList.m
//  IOSClientApiTester
//
//  Created by felix on 7/25/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "QuoteSizeList.h"
#import "JEDIDateTime.h"
#import "JEDISystem.h"

static NSString * gs_QSList_jsonId  =@"QuoteSizeList";
static NSString * gs_QSList_sizes   =@"1";


@implementation QuoteSizeList

//-------------------------------------------------------------
-(id)               init
{
    self = [super init];
    
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:gs_QSList_jsonId];
    }
    
    return self;
}

//-------------------------------------------------------------
-(NSMutableArray *) getSizes // QuoteSizeData[]
{
    JEDI_SYS_Try
    {
        return [super getEntryArray:gs_QSList_sizes];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(void)             setSizes:(NSMutableArray *) sizes
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_QSList_sizes entry:sizes];
    }
    JEDI_SYS_EndTry
}

@end
