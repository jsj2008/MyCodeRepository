//
//  QuoteList.m
//  IOSClientApiTester
//
//  Created by felix on 7/25/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "QuoteList.h"
#import "JEDIDateTime.h"
#import "JEDISystem.h"

static NSString * gs_QList_jsonId  =@"QuoteList";
static NSString * gs_QList_sizes   =@"1";

@implementation QuoteList


//-------------------------------------------------------------
-(id)               init
{
    self = [super init];
    
    if(self != nil)
    {
        [super setEntry:@"jsonId" entry:gs_QList_jsonId];
    }
    
    return self;
}

//-------------------------------------------------------------
-(NSMutableArray *) getQuotes // QuoteData[]
{
    JEDI_SYS_Try
    {
        return [super getEntryArray:gs_QList_sizes];
    }
    JEDI_SYS_EndTry
    
    return nil;
}

//-------------------------------------------------------------
-(void)             setQuotes:(NSMutableArray *) quotes
{
    JEDI_SYS_Try
    {
        [super setEntry:gs_QList_sizes entry:quotes];
    }
    JEDI_SYS_EndTry
}

@end
