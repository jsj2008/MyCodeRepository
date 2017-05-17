//
//  SendDeviceUtil.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/3/17.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendDeviceUtil : NSObject

+ (void)sendDevice:(NSString *)account;

+ (void)sendPriceWarningRead;

@end
