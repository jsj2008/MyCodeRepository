//
//  API_Event_QuoteDataStore.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/20.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDS_PriceSnapShot.h"

@protocol API_Event_QuoteDataStore <NSObject>

- (void)recQuoteData:(CDS_PriceSnapShot *)snapshot;

@end
