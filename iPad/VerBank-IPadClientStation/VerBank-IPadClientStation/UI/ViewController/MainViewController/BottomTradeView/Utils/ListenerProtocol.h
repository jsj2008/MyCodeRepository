//
//  ListenerProtocol.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/5.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListenerProtocol <NSObject>

- (void)addListener;
- (void)removeListener;

@end
