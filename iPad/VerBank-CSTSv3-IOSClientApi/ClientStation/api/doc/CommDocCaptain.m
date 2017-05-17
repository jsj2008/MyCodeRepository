//
//  CommDocCaptain.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocCaptain.h"
#import "KeyNotFundException.h"

static CommDocCaptain *gs_CommDocCaptain_instance = nil;

@interface CommDocCaptain(){
    SystemDocCaptain    *_systemDocCaptain;
    UserDocCaptain      *_userDocCaptain;
    FixUtil             *_fixUtil;
    DayUtil             *_dayUtil;
    DocUtil             *_docUtil;
    AccountDigestUtil   *_accountDigestUtil;
    CloseOpenUtil       *_closeOpenUtil;
    GeneralCalculateUtil*_generalCalculateUtil;
    ExchangeUtil        *_exchangeUtil;
    InterestUtil        *_interestUtil;
    GeneralCheckUtil    *_generalCheckUtil;
    Boolean             _inited;
    
    NSMutableDictionary      *_instrumentUtilDic;
}

@end

@implementation CommDocCaptain

- (id)init{
    if (self = [super init]) {
        _systemDocCaptain = [[SystemDocCaptain alloc] init];
        _userDocCaptain = [[UserDocCaptain alloc] init];
        _fixUtil = [[FixUtil alloc] init];
        _dayUtil = [[DayUtil alloc] init];
        _docUtil = [[DocUtil alloc] init];
        _accountDigestUtil = [[AccountDigestUtil alloc] init];
        _closeOpenUtil = [[CloseOpenUtil alloc] init];
        _generalCalculateUtil = [[GeneralCalculateUtil alloc] init];
        _exchangeUtil = [[ExchangeUtil alloc] init];
        _interestUtil = [[InterestUtil alloc] init];
        _generalCheckUtil = [[GeneralCheckUtil alloc] init];
        _instrumentUtilDic = [[NSMutableDictionary alloc] init];
        _inited = false;
    }
    return self;
}

+ (CommDocCaptain *) getInstance{
    if(gs_CommDocCaptain_instance == nil){
        gs_CommDocCaptain_instance = [[CommDocCaptain alloc] init];
    }
    return gs_CommDocCaptain_instance;
}

- (void)destroy{
    gs_CommDocCaptain_instance = nil;
    _systemDocCaptain = nil;
    _userDocCaptain = nil;
    _fixUtil = nil;
    _dayUtil = nil;
    _docUtil = nil;
    _accountDigestUtil = nil;
    _closeOpenUtil = nil;
    _generalCalculateUtil = nil;
    _exchangeUtil = nil;
    _interestUtil = nil;
    _generalCheckUtil = nil;
    _instrumentUtilDic = nil;
    _inited = false;
}

- (ExchangeUtil *)getExchangeUtil{
    return _exchangeUtil;
}

- (CloseOpenUtil *)getCloseOpenUtil{
    return _closeOpenUtil;
}

- (SystemDocCaptain *)getSystemDocCaptain{
    return _systemDocCaptain;
}

- (UserDocCaptain *)getUserDocCaptain{
    return _userDocCaptain;
}

- (InstrumentUtil *)getInstrumentUtil:(NSString *)instrument{
    Instrument *inst = [_systemDocCaptain getInstrument:instrument];
    if (inst == nil || instrument == nil) {
//        @throw [[KeyNotFundException alloc] initWithKeyName:@"instrument"  Object:instrument];
        return nil;
    }
    
    InstrumentUtil *util = [_instrumentUtilDic objectForKey:instrument];
    if (util == nil) {
//        util = [[InstrumentUtil alloc] initWithInstrument:inst
//                                         SystemDocCaptain:_systemDocCaptain
//                                           UserDocCaptain:_userDocCaptain];
        util = [[InstrumentUtil alloc] initWithInstrument:inst];
        [_instrumentUtilDic setObject:util forKey:instrument];
    }
    //    InstrumentUtil *util = [[InstrumentUtil alloc] initWithInstrument:inst
    //                                     SystemDocCaptain:_systemDocCaptain
    //                                       UserDocCaptain:_userDocCaptain];
    return util;
}

- (FixUtil *)getFixUtil{
    return _fixUtil;
}

//- (PriceSnapShotUtil *)getPriceSnapShotUtil:(CDS_PriceSnapShot *)priceSnapShot{
//    return [PriceSnapShotUtil newInstance:priceSnapShot];
//}

- (DayUtil *)getDayUtil{
    return _dayUtil;
}

- (GeneralCalculateUtil *)getGeneralCalculateUtil{
    return _generalCalculateUtil;
}

- (AccountDigestUtil *)getAccountDigestUtil{
    return _accountDigestUtil;
}

- (Boolean)isInited{
    return _inited;
}

- (void)setInited:(Boolean)isInited{
    _inited = isInited;
}

- (DocUtil *)getDocUtil{
    return _docUtil;
}

- (InterestUtil *)getInterestUtil{
    return _interestUtil;
}

- (GeneralCheckUtil *)getGeneralCheckUtil{
    return _generalCheckUtil;
}

@end
