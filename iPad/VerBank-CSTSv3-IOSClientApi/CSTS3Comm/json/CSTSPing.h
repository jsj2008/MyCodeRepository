//
//  CSTSPing.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/16/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "AbstractJsonData.h"


@interface CSTSPing : AbstractJsonData

- (id)          init;
- (NSString *)  getID;

- (void)        pingReturned;
- (long)        getPing;

- (long long)   getStartTime;
- (void)        setStartTime:(long long) time;

- (long long)   getEndTime;

- (long)        getServerDelay;
- (void)        setServerDelay:(long) delay;

@end
