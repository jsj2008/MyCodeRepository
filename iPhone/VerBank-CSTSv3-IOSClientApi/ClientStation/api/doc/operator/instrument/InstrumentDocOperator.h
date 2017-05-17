//
//  InstrumentDocOperator.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/9.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

static int SEARCH_TYPE_ALL = 0;
static int SEARCH_TYPE_INSTRUMENTVECTOR = 1;

@interface InstrumentDocOperator : NSObject

+ (InstrumentDocOperator *)getInstance;
- (Boolean)loadInstruments;
- (Boolean)loadInstruments:(NSString *)instrument;
- (Boolean)loadQuoteTable:(NSArray *)instrumentArray;
- (Boolean)loadInstrumentsGroupCfg:(NSString *)groupName;
- (Boolean)loadInstrumentsAccountCfg:(long long)accountID;
- (Boolean)loadInstrumentsGroupCfg:(NSString *)groupName
                        instrument:(NSString *)instrument;
- (Boolean)loadInstrumentsAccountCfg:(long long)accountID
                          instrument:(NSString *)instrument;

@end
