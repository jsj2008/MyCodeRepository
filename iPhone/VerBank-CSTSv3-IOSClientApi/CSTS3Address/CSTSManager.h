//
//  CSTSManager.h
//  IOSClientStation
//
//  Created by felix on 9/4/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTSMgrProxy.h"


@interface CSTSManager : NSObject <CSTSMgrProxyDelegate>
{
@private
    NSMutableArray  * mMgrNodes;
    NSMutableArray  * mProxyArray;
    NSMutableArray  * mCSTSNodes;
}

//
// AddressNode
//
+ (NSMutableArray *) addressNodesFromManagers:(NSArray *) mgrNodes userName:(NSString *) userName;
+ (BOOL)             isNetworkOk;


- (id)                  initWithNodes:(NSArray *) mgrNodes;
- (NSMutableArray *)    queryAddresses:(NSString *) userName;

//
// CSTSMgrProxyDelegate
//
- (void)    didQueryFromServer:(NSMutableArray *) nodeArray cstsProxy:(id)proxy;

@end
