//
//  PhonePinChecker.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/21.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhonePinChecker : NSObject

+ (PhonePinChecker *)getInstance;
- (void)destroy;

- (Boolean)checkPhonePinByValidate;
- (Boolean)checkIsneedputPhonePin;

- (void)resetTimeTick;
- (void)resetByTime:(long long)crossTime;

@end
