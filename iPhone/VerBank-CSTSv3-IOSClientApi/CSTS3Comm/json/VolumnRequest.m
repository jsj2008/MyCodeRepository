//
//  VolumnRequest.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "VolumnRequest.h"

NSString *volumnRequest_jsonId      =@"VolumnRequest";
NSString *volumnRequest_instruments =@"1";

@implementation VolumnRequest

- (id)init
{
    self = [super init];
    if (self) {
        [super setEntry:@"jsonId" entry:volumnRequest_jsonId];
    }
    return self;
}

-(NSMutableArray *)getInstruments
{
    @try {
        return [super getEntryArray:volumnRequest_instruments];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

-(void)setInstruments:(NSMutableArray *)instruments
{
    [super setEntry:volumnRequest_instruments entry:instruments];
}
@end
