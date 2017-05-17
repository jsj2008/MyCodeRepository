//
//  PingPack.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/17/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTSPing.h"


@interface PingPack : NSObject
{
@private
    CSTSPing  * mPing;
    
    BOOL        mIsTimeout;
    BOOL        mIsReturned;
    BOOL        mIsIgnore;
}

- (id) init;
- (id) initWithPing:(CSTSPing *) ping;

- (NSString *) getKey;

- (BOOL) isTimeout;
- (BOOL) isIgnore;
- (long) getPing;

- (void) pingReturn:(CSTSPing *) ping;
- (void) ignore;

- (void) doWait;

@end
