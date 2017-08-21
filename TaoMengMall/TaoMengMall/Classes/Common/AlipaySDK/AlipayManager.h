//
//  AlipayManager.h
//  LianWei
//
//  Created by marco on 8/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@interface AlipayManager : NSObject

@property (nonatomic, copy) CompletionBlock completion;

+ (BOOL)registerScheme:(NSString *)schemeStr withDescription:(NSString *)appdesc;

+ (instancetype)sharedManager;

- (void)payOrder:(NSString *)orderStr
        callback:(CompletionBlock)completionBlock;

- (void)processOrderWithPaymentResult:(NSURL *)resultUrl
                      standbyCallback:(CompletionBlock)completionBlock;
@end
