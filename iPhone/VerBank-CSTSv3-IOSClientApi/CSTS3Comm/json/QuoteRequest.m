//
//  QuoteRequest.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "QuoteRequest.h"

NSString * quoteRequest_jsonId          =@"QuoteRequest";
NSString * quoteRequeset_instruments    =@"1";

@implementation QuoteRequest

- (id)init
{
    self = [super init];
    if (self) {
        [super setEntry:@"jsonId" entry:quoteRequest_jsonId];
    }
    return self;
}

-(NSMutableArray *)getInstruments{
    @try {
        return [super getEntryArray:quoteRequeset_instruments];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

-(void)setInstruments:(NSMutableArray *)instruments
{
    [super setEntry:quoteRequeset_instruments entry:instruments];
}

@end
