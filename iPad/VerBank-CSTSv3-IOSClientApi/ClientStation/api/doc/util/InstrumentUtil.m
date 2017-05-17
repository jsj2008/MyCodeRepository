//
//  InstrumentUtil.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "InstrumentUtil.h"
#import "KeyNotFundException.h"
#import "CommDocCaptain.h"

@interface InstrumentUtil(){
    NSString            *_instrumentName;
    Instrument          *_instrumentNode;
    double              onePointPrice;
    
    NSNumberFormatter   *_clientFormat;
    //    SystemDocCaptain    *_systemDocCaptain;
    //    UserDocCaptain      *_userDocCaptain;
}

@end

@implementation InstrumentUtil

- (id)initWithInstrument:(Instrument *)instrument {
    
    if (self = [super init]) {
        _instrumentNode = instrument;
        //        _systemDocCaptain = systemDocCaptain;
        //        _userDocCaptain = userDocCaptain;
        _instrumentName = [instrument getInstrument];
        
        
        
        double opp = 1;
        for (int i = 0; i < [_instrumentNode getDigits]; i++) {
            opp /= 10.0;
        }
        
        onePointPrice = opp;
        
        //        _format = [[NSNumberFormatter alloc] init];
        //        [_format setMinimumFractionDigits:[_instrumentNode getDigits] + [_instrumentNode getExtraDigit]];
        //        [_format setMaximumFractionDigits:[_instrumentNode getDigits] + [_instrumentNode getExtraDigit]];
        // /////////////////////////////////////
        int digits = [_instrumentNode getDigits];
        if (digits > 0) {
            digits++;
        }
        _clientFormat = [[NSNumberFormatter alloc] init];
        [_clientFormat setMinimumIntegerDigits:1];
        [_clientFormat setMaximumFractionDigits:digits];
        [_clientFormat setMinimumFractionDigits:digits];

    }
    return self;
}

- (double)getOnePointPrice{
    return onePointPrice;
}

//- (NSString *)formatPrice:(double)price{
//    @synchronized (_format) {
//        return [_format stringFromNumber:[[NSNumber alloc] initWithDouble:price]];
//    }
//}

- (NSString *)formatClientPrice:(double)price {
    NSString *priceStr;
    @synchronized (_clientFormat) {
        priceStr = [_clientFormat stringFromNumber:[[NSNumber alloc] initWithDouble:price]];
    }
    if ([_instrumentNode getDigits] > 0) {
        priceStr = [priceStr substringWithRange:NSMakeRange(0, priceStr.length - 1)];
    }
    return priceStr;
}

- (NSString *)formatClientPrice:(double)price isFloor:(Boolean)isFloor{
    NSString *priceStr;
    @synchronized (_clientFormat) {
        JEDI_SYS_Try{
            if (!isFloor) {
                //                price += pow(10, -([_instrumentNode getDigits]));
                int digit = [_instrumentNode getDigits] + [_instrumentNode getExtraDigit];
                int temp = pow(10, digit);
                price = ceil(price * temp) / temp;
            } else {
                int digit = [_instrumentNode getDigits] + [_instrumentNode getExtraDigit];
                int temp = pow(10, digit);
                price = floor(price * temp) / temp;
            }
            NSNumber *number = [[NSNumber alloc] initWithDouble:price];
            priceStr = [_clientFormat stringFromNumber:number];
        } JEDI_SYS_EndTry
    }
    if ([_instrumentNode getDigits] > 0) {
        
        NSRange range = NSMakeRange(0, priceStr.length - 1);
        priceStr = [priceStr substringWithRange:range];
        
    }
    return priceStr;
}

- (Instrument *)getInstrumentNode{
    return _instrumentNode;
}

- (CDS_PriceShift *)getPriceShift4AccountWithAccountID:(long long)accountID{
    CDS_PriceShift *priceShiftAccount = [[CDS_PriceShift alloc] init];
    [priceShiftAccount setInstrument:_instrumentName];
    //    InstrumentsAccountCfg *iac = [_systemDocCaptain getInstrumentsAccountCfg:accountID :[_instrumentNode getInstrument]];
    InstrumentsAccountCfg *iac = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsAccountCfg:accountID :_instrumentName];
    if (iac != nil) {
        [priceShiftAccount setAskShift:[iac getSpread2Add] * onePointPrice];
        [priceShiftAccount setBidShift:[iac getSpread2Add] * onePointPrice];
    }
    return priceShiftAccount;
}

- (CDS_PriceShift *)getPriceShift4GroupWithGroupName:(NSString *)groupName{
    CDS_PriceShift *priceShiftGroup = [[CDS_PriceShift alloc] init];
    [priceShiftGroup setInstrument:_instrumentName];
    //    InstrumentsGroupCfg *igc = [_systemDocCaptain getInstrumentsGroupCfg:groupName :[_instrumentNode getInstrument]];
    InstrumentsGroupCfg *igc = [[[CommDocCaptain getInstance] getSystemDocCaptain] getInstrumentsGroupCfg:groupName :_instrumentName];
    
    if (igc != nil) {
        [priceShiftGroup setAskShift:[igc getSpread2Add] * onePointPrice];
        [priceShiftGroup setBidShift:[igc getSpread2Add] * onePointPrice];
    }
    return priceShiftGroup;
}

- (CDS_PriceSnapShot *)getPriceSnapShot{
    QuoteData *quoteData = [[[CommDocCaptain getInstance] getSystemDocCaptain] getQuote:_instrumentName];
    if (quoteData == nil) {
        @throw [[KeyNotFundException alloc] initWithKeyName:@"Quote"  Object:_instrumentName];
    }
    //    CDS_PriceSnapShot *priceSnapShot = [[CDS_PriceSnapShot alloc] initWithInstrumentName:[_instrumentNode getInstrument]];
    CDS_PriceSnapShot *priceSnapShot = [[CDS_PriceSnapShot alloc] init];
    [priceSnapShot setInstrumentName:_instrumentName];
    //    @synchronized(priceSnapShot) {
    [priceSnapShot setDigits:[_instrumentNode getDigits] + [_instrumentNode getExtraDigit]];
    [priceSnapShot setBasicAsk:[quoteData getAsk]];
    [priceSnapShot setBasicBid:[quoteData getBid]];
    [priceSnapShot setBankName_ask:[quoteData getAskBank]];
    [priceSnapShot setBankName_bid:[quoteData getBidBank]];
    [priceSnapShot setQuoteID_ask:[quoteData getAskId]];
    [priceSnapShot setQuoteID_bid:[quoteData getBidId]];
    [priceSnapShot setOpenPrice:[quoteData getOpenPrice]];
    [priceSnapShot setHighPrice:[quoteData getHighPrice]];
    [priceSnapShot setLowPrice:[quoteData getLowPrice]];
    [priceSnapShot setLastAsk:[quoteData getLastAsk]];
    [priceSnapShot setLastBid:[quoteData getLastBid]];
    [priceSnapShot setYClosePrice:[quoteData getYclosePrice]];
    [priceSnapShot setQuoteDay:[quoteData getQuoteDay]];
    [priceSnapShot setSnapshotTime:[quoteData getQuoteTime]];
    [priceSnapShot setClose:[quoteData getClose]];
    //    }
    
    return priceSnapShot;
}

- (CDS_PriceSnapShot *)getPriceSnapShotWithAccountID:(long long)accountID{
    CDS_PriceSnapShot *priceSnapShotAccount = [self getPriceSnapShot];
    [priceSnapShotAccount setAccountID:accountID];
    [priceSnapShotAccount setPriceShift4Account:[self getPriceShift4AccountWithAccountID:accountID]];
    NSString *groupName = [[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:accountID];
    
    if (groupName == nil) {
        @throw [[KeyNotFundException alloc] initWithKeyName:@"Group for account"  Object:[NSString stringWithFormat:@"%lld", accountID]];
    }
    [priceSnapShotAccount setPriceShift4Group:[self getPriceShift4GroupWithGroupName:groupName]];
    return priceSnapShotAccount;
}

- (CDS_PriceSnapShot *)getPriceSnapShot4GivenPriceWitBid:(double)bid  Ask:(double)ask{
    //    CDS_PriceSnapShot *priceSnapShotGivenPrice = [[CDS_PriceSnapShot alloc] initWithInstrumentName:[_instrumentNode getInstrument]];
    CDS_PriceSnapShot *priceSnapShotGivenPrice = [[CDS_PriceSnapShot alloc] init];
    [priceSnapShotGivenPrice setInstrumentName:_instrumentName];
    [priceSnapShotGivenPrice setDigits:[_instrumentNode getDigits] + [_instrumentNode getExtraDigit]];
    [priceSnapShotGivenPrice setBasicAsk:ask];
    [priceSnapShotGivenPrice setBasicBid:bid];
    return priceSnapShotGivenPrice;
}

- (CDS_PriceSnapShot *)getPriceSnapShot4GivenPriceWithAccountID:(long long)accountID  Bid:(double)bid  Ask:(double)ask{
    CDS_PriceSnapShot *priceSnapShotGivenPrice = [self getPriceSnapShot4GivenPriceWitBid:bid  Ask:ask];
    [priceSnapShotGivenPrice setAccountID:accountID];
    [priceSnapShotGivenPrice setPriceShift4Account:[self getPriceShift4AccountWithAccountID:accountID]];
    NSString *groupName = [[[CommDocCaptain getInstance] getUserDocCaptain] getGroupNameByAccount:accountID];
    
    if (groupName == nil) {
        @throw [[KeyNotFundException alloc] initWithKeyName:@"Group for account"  Object:[NSString stringWithFormat:@"%lld", accountID]];
    }
    [priceSnapShotGivenPrice setPriceShift4Group:[self getPriceShift4GroupWithGroupName:groupName]];
    return priceSnapShotGivenPrice;
}

- (int)getOrderTradeCostWithAccountID:(long long)accountID{
    GroupDoc *groupDoc = [[[CommDocCaptain getInstance] getUserDocCaptain] getGroupDocByAccount:accountID];
    return [[groupDoc groupConfig] getOrderTradeFee] * [_instrumentNode getOrderTradeFeeRatio] + [_instrumentNode getOrderTradeFeeAdjust];
}

- (NSString *)getInstrumentName{
    return _instrumentName;
}

- (void)dealloc {
    _clientFormat = nil;
    //    priceSnapShot = nil;
    //    priceShiftGroup = nil;
    //    priceShiftAccount = nil;
    //    priceSnapShotAccount = nil;
    //    priceSnapShotGivenPrice = nil;
}

@end
