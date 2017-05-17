//
//  APIDoc.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "APIDoc.h"

@implementation APIDoc

+(CloseOpenUtil *)getCloseOpenUtil{
    return [[CommDocCaptain getInstance] getCloseOpenUtil];
}

+ (DayUtil *)getDayUtil{
    return [[CommDocCaptain getInstance] getDayUtil];
}

+ (ExchangeUtil *)getExchangeUtil{
    return [[CommDocCaptain getInstance] getExchangeUtil];
}

+ (FixUtil *) getFixUtil{
    return [[CommDocCaptain getInstance] getFixUtil];
}

+ (GeneralCalculateUtil *) getGeneralCalculateUtil{
    return [[CommDocCaptain getInstance] getGeneralCalculateUtil];
}

+ (InstrumentUtil *) getInstrumentUtil:(NSString *) instrument{
    return [[CommDocCaptain getInstance] getInstrumentUtil:instrument];
}

//+ (PriceSnapShotUtil *)getPriceSnapShotUtil:(CDS_PriceSnapShot *)priceSnapShot{
//    return [[CommDocCaptain getInstance] getPriceSnapShotUtil:priceSnapShot];
//}

+ (SystemDocCaptain *)getSystemDocCaptain{
    return [[CommDocCaptain getInstance] getSystemDocCaptain];
}

+ (UserDocCaptain *)getUserDocCaptain{
    return [[CommDocCaptain getInstance] getUserDocCaptain];
}

+ (AccountDigestUtil *)getAccountDigestUtil{
    return [[CommDocCaptain getInstance] getAccountDigestUtil];
}

+ (Boolean)isInited{
    return [[CommDocCaptain getInstance] isInited];
}

+ (void)setInited:(Boolean)inited{
    [[CommDocCaptain getInstance] setInited:inited];
}

+ (DocUtil *)getDocUtil{
    return [[CommDocCaptain getInstance] getDocUtil];
}

+ (GeneralCheckUtil *)getGeneralCheckUtil{
    return [[CommDocCaptain getInstance] getGeneralCheckUtil];
}

+ (InterestUtil *)getInterestUtil{
    return [[CommDocCaptain getInstance] getInterestUtil];
}

@end
