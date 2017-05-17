//
//  SendDeviceUtil.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/3/17.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "SendDeviceUtil.h"
#import "APIDoc.h"
#import "TradeApi.h"
#import "UserDefaultsSettingKey.h"
#import "ClientAPI.h"
#import "PriceWarning.h"
#import "MTP4CommDataInterface.h"

@implementation SendDeviceUtil

+ (void)sendDevice:(NSString *)account {
    
    [NSThread detachNewThreadSelector:@selector(setDeviceToken:)
                             toTarget:self
                           withObject:account];
}

+ (void)setDeviceToken:(id)account {
    int time = 3;
    while (time > 0) {
        time--;
        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceTokenKey];
        TradeResult *result = [[TradeApi getInstance] setDeviceTokenAeid:[[ClientAPI getInstance] aeid]
                                                               accountID:account
                                                               groupName:[[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:[account longLongValue]]
                                                             deviceToken:deviceToken
                                                              deviceType:PUSH_TYPE_IPHONE];
        [NSThread sleepForTimeInterval:3];
        if ([result succeed]) {
            return;
        }
    }
    NSLog(@"device token register failed");
}

+ (void)sendPriceWarningRead {
    [NSThread detachNewThreadSelector:@selector(setPriceWarningRead)
                             toTarget:self
                           withObject:nil];
}

+ (void)setPriceWarningRead {
    NSArray *priceWarningArray = [[TradeApi getInstance] queryPriceWarning4NoRead];
    if (priceWarningArray != nil && [priceWarningArray count] != 0) {
        for (PriceWarning *priceWarning in priceWarningArray) {
            if ([priceWarning getOrigin] == ROLETYPE_USER) {
                [[TradeApi getInstance] readPriceWarning:[priceWarning getGuid]];
            }
        }
    }
}

@end
