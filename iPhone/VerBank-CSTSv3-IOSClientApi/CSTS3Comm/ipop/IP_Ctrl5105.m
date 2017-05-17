//
//  IP_Ctrl5105.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/10/21.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "IP_Ctrl5105.h"

static NSString *jsonId                 = @"IP_Ctrl5105";

static NSString *aeid                   = @"1";
static NSString *deviceType             = @"2";
static NSString *deviceID               = @"3";
static NSString *venderID               = @"4";
static NSString *certSerial             = @"5";

@implementation IP_Ctrl5105

-(id)init {
    if (self = [super init]) {
        [super setEntry:@"jsonId" entry:jsonId];
    }
    return self;
}

jsonImplementionString  (Aeid,          aeid)
jsonImplementionString  (DeviceType,    deviceType)
jsonImplementionString  (DeviceID,      deviceID)
jsonImplementionString  (VenderID,      venderID)
jsonImplementionString  (CertSerial,    certSerial)

@end
