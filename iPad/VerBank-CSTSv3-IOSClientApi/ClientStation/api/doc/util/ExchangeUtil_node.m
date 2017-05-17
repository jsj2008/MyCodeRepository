//
//  ExchangeUtil_node.m
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/2.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "ExchangeUtil_node.h"
#import "DataUtil.h"

@interface ExchangeUtil_node(){
//    NSString *ccy1;
//    NSString *ccy2;
//    double amount;
//    Instrument *instrument;
//    double bid;
//    double ask;
    Boolean _isStrightConbert;
    Boolean _useMidPrice;
}

@end

@implementation ExchangeUtil_node

@synthesize ccy1 = _ccy1;
@synthesize ccy2 = _ccy2;
@synthesize amount = _amount;
@synthesize instrument = _instrument;
@synthesize bid = _bid;
@synthesize ask =_ask;

- (id)initWithCcy1:(NSString *)ccy1  Ccy2:(NSString *)ccy2  Amount:(double)amount  Instrument:(Instrument *)instrument  Bid:(double)bid  Ask:(double)ask  UseMidPrice:(Boolean)useMidPrice{
    if (self = [super init]) {
        _ccy1 = ccy1;
        _ccy2 = ccy2;
        _amount = amount;
        _instrument = instrument;
        _bid = bid;
        _ask = ask;
        if (instrument == nil) {
            _isStrightConbert = true;
        } else {
            _isStrightConbert = [[instrument getCcy2] isEqualToString:ccy2];
        }
        _useMidPrice = useMidPrice;
    }
    return  self;
}

- (id)initWithCcy1:(NSString *)ccy1  Ccy2:(NSString *)ccy2  Amount:(double)amount  Instrument:(Instrument *)instrument  Bid:(double)bid  Ask:(double)ask{
    return [self initWithCcy1:ccy1  Ccy2:ccy2  Amount:amount  Instrument:instrument  Bid:bid  Ask:ask  UseMidPrice:false];
}

- (double)getExchangeMoney{
    double price = [self getExchangePrice];
    return [self exchangeForBalanceCurr:price];
}

- (double)exchangeForBalanceCurr:(double)price{
    double tempAmount = [self __exchangeForBalanceCurr:price];
    return [DataUtil roundDouble:tempAmount _scale:2];
}

- (double)__exchangeForBalanceCurr:(double)price{
    double tempAmount = [self fixOriAmount:_amount :_ccy1];
    if (_isStrightConbert) {
        if (tempAmount > 0.0001) {
            return tempAmount * price;
        } else {
            return tempAmount * price;
        }
    } else {
        if (tempAmount > 0.0001) {
            return tempAmount / price;
        } else {
            return tempAmount / price;
        }
    }
}

- (double)fixOriAmount:(double)amount :(NSString *)ccy{
    if ([[ccy uppercaseString] isEqualToString:@"JPY"]) {
        return [DataUtil roundDouble:amount _scale:0];
    } else {
        return [DataUtil roundDouble:amount _scale:2];
    }
}

- (double)getExchangePrice{
    if (_useMidPrice) {
        return (_ask + _bid) / 2.0;
    } else {
        if (_isStrightConbert) {
            if (_amount > 0.0001) {
                return _bid;
            } else {
                return _ask;
            }
        } else {
            if (_amount > 0.0001) {
                return _ask;
            } else {
                return _bid;
            }
        }
    }
}

- (NSString *)getInstrument{
    if (_isStrightConbert) {
        return @"";
    }
    return [_instrument getInstrument];
}



@end
