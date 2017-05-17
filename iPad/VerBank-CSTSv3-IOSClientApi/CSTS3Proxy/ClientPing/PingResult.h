//
//  PingResult.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingResult : NSObject

@property (nonatomic) BOOL IsTimeout;
@property (nonatomic) long TimeOfPing;
@property (nonatomic) long AveragePing;

@property (nonatomic) double LostPerc;

- (NSString *) toString;

@end
