//
//  SpeedChecker.h
//  IOSClientStation
//
//  Created by felix on 8/8/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressChecker.h"

@interface SpeedChecker : NSObject <AddressCheckerDelegate>

- (id)  init;

- (void)checkSpeed:(NSArray *) nodeArray;

@end
