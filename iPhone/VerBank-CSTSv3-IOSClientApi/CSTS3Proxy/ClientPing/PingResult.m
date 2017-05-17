//
//  PingResult.m
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "PingResult.h"

@implementation PingResult

- (NSString *) toString
{
    NSString * str = [NSString stringWithFormat:@"[Ping] Is timeout : %@, ping= %ld, ave Ping= %ld, lost per= %.5f"
                      , self.IsTimeout ? @"true" : @"false"
                      , self.TimeOfPing
                      , self.AveragePing
                      , self.LostPerc
                      ];
    return str;
}

@end
