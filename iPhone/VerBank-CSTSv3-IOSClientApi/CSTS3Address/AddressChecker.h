//
//  AddressChecker.h
//  IOSClientStation
//
//  Created by felix on 8/8/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEDINetwork.h"
#import "AddressNode.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol AddressCheckerDelegate
@optional
- (void)    didAddressCheck:(AddressNode *) node;
@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface AddressChecker : NSObject <JEDINetworkDelegate>

- (id)      initWithNode:(AddressNode *) node andDelegate:(id <AddressCheckerDelegate>) delegate;

- (void)    startChecking;
- (void)    stopChecking;

@end


