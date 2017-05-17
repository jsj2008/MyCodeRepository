//
//  QuoteDataStore.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/20.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDS_PriceSnapShot.h"
#import "API_Event_QuoteDataStore.h"
static Boolean inited = false;

@interface QuoteDataStore : NSObject

+ (Boolean)getInited;
+ (void)setInited:(Boolean)init;

+ (id)getInstance;
- (void)recQuoteData:(CDS_PriceSnapShot *)quoteData;
- (CDS_PriceSnapShot *)getQuoteData:(NSString *)instrument;
- (CDS_PriceSnapShot *)getLastQuoteData:(NSString *)instrument;

+ (void)addQuoteReceiver:(id<API_Event_QuoteDataStore>)delegate;
+ (void)removeQuoteReceiver:(id<API_Event_QuoteDataStore>)delegate;

- (void)destroy;

@end
