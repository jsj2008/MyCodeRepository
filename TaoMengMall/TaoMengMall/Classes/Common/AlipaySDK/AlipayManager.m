//
//  AlipayManager.m
//  LianWei
//
//  Created by marco on 8/11/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "AlipayManager.h"

@interface AlipayManager ()
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appdesc;
@end

@implementation AlipayManager


static AlipayManager *instance = nil;

+(instancetype)sharedManager {
    if (!instance) {
        NSLog(@"Please use +registerScheme:withDescription: to init AlipayManager first.");
    }
    return instance;
}

+ (BOOL)registerScheme:(NSString *)schemeStr withDescription:(NSString *)appdesc
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AlipayManager alloc] initWithURLScheme:schemeStr description:appdesc];
    });
    return instance?YES:NO;
}

- (instancetype)initWithURLScheme:(NSString*)urlScheme description:(NSString *)appdesc
{
    if (self = [super init]) {
        _urlScheme = urlScheme;
        _appdesc = appdesc;
    }
    return self;
}

- (void)payOrder:(NSString *)orderStr
        callback:(CompletionBlock)completionBlock
{
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:self.urlScheme callback:completionBlock?completionBlock:self.completion];
}

- (void)processOrderWithPaymentResult:(NSURL *)resultUrl
                      standbyCallback:(CompletionBlock)completionBlock
{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:resultUrl standbyCallback:completionBlock?completionBlock:self.completion];
}
@end
