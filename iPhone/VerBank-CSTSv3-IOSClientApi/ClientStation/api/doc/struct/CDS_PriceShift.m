//
//  CDS_PriceShift.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CDS_PriceShift.h"

@implementation CDS_PriceShift

@synthesize instrument;
@synthesize bidShift;
@synthesize askShift;

- (id)copy{
    return [super copy];
}

- (void)dealloc {
    instrument = nil;
}

@end
