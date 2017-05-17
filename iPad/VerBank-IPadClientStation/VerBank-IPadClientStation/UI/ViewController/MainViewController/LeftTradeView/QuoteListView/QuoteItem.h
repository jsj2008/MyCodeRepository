//
//  QuoteItem.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/14.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteItem : NSObject{
    NSString *_instrument;
    NSString *_highPrice;
    NSString *_lowPricel;
    NSString *_quoteTime;
    NSString *_ask;
    NSString *_bid;
    NSString *_upDownPirce;
    NSString *_upDownPricePercent;
    int _upDown;
    int _extradigit;
}

@property (strong, retain) NSString *instrument;
@property (strong, retain) NSString *highPrice;
@property (strong, retain) NSString *lowPricel;
@property (strong, retain) NSString *quoteTime;
@property (strong, retain) NSString *ask;
@property (strong, retain) NSString *bid;
@property (strong, retain) NSString *upDownPrice;
@property (strong, retain) NSString *upDownPricePercent;
@property int upDown;
@property int extradigit;

@end
