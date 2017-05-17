//
//  QuoteDataStore.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/20.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "QuoteDataStore.h"
#import "APIDoc.h"
#import "ClientAPI.h"

static     QuoteDataStore *quoteDataStore = nil;
static     NSMutableArray * quoteEventListenerArray = nil;

@interface QuoteDataStore()<API_Event_QuoteDataStore>{
    
    NSMutableDictionary *quoteDataDic;
    NSMutableDictionary *lastQuoteDic;
    
    NSMutableDictionary *sendDic;
    
    NSObject *lock;
    
    Boolean isDestroy;
    
    //    NSObject *sendDicLock;
    
}

@end

@implementation QuoteDataStore

+ (Boolean)getInited{
    return inited;
}

+ (void)setInited:(Boolean)init{
    inited = init;
}

+ (id)getInstance{
    if (quoteDataStore == nil) {
        quoteDataStore = [[QuoteDataStore alloc] init];
    }
    return quoteDataStore;
}

- (id)init{
    if (self = [super init]) {
        quoteDataDic = [[NSMutableDictionary alloc] init];
        lastQuoteDic = [[NSMutableDictionary alloc] init];
        sendDic = [[NSMutableDictionary alloc] init];
        //        sendDicLock = [[NSObject alloc] init];
        lock = [[NSObject alloc] init];
        [self initQuoteDataStore];
        isDestroy = false;
        [self addSender];
    }
    return self;
}

- (void)initQuoteDataStore{
    NSArray *list = [[APIDoc getSystemDocCaptain] getInstrumentArray];
    if(list != nil){
        for (Instrument *instrument in list) {
            JEDI_SYS_Try{
                InstrumentUtil *instrumentUtil = [APIDoc getInstrumentUtil:[instrument getInstrument]];
                if (instrumentUtil != nil) {
                    CDS_PriceSnapShot *pss = [instrumentUtil getPriceSnapShotWithAccountID:[[ClientAPI getInstance] accountID]];
                    if (pss != nil) {
                        [self recQuoteData:pss];
                    }
                }
            }JEDI_SYS_EndTry
        }
    }
}

- (void)recQuoteData:(CDS_PriceSnapShot *)quoteData{
    @synchronized(lock){
        if (quoteData != nil) {
            CDS_PriceSnapShot *data = [quoteDataDic objectForKey:[quoteData instrumentName]];
            Boolean bol = true;
            if (data != nil) {
                bol = ([quoteData snapshotTime] != [data snapshotTime]);
            }
            if (bol) {
                CDS_PriceSnapShot *origQuote  = [quoteDataDic objectForKey:[quoteData instrumentName]];
                if (origQuote != nil) {
                    [lastQuoteDic setObject:origQuote forKey:[origQuote instrumentName]];
                }
                [quoteDataDic setObject:quoteData forKey:[quoteData instrumentName]];
                @synchronized(sendDic){
                    [sendDic setObject:quoteData forKey:[quoteData instrumentName]];
                }
            }
        }
    }
}

- (CDS_PriceSnapShot *)getQuoteData:(NSString *)instrument{
    @synchronized(lock){
        CDS_PriceSnapShot *pss = [quoteDataDic objectForKey:instrument];
        if (pss == nil) {
            @try{
                InstrumentUtil *instUtil = [APIDoc getInstrumentUtil:instrument];
                if (instUtil != nil) {
                    pss = [instUtil getPriceSnapShotWithAccountID:[[ClientAPI getInstance] accountID]];
                    //                    [self recQuoteData:pss];
                }
                return pss;
            }@catch (NSException *exception) {
                NSLog(@"......err !!! %@", [exception reason]);
                return [[CDS_PriceSnapShot alloc] init];
            }
        } else{
            return pss;
        }
    }
}

- (CDS_PriceSnapShot *)getLastQuoteData:(NSString *)instrument{
    CDS_PriceSnapShot *data = [lastQuoteDic objectForKey:instrument];
    return data == nil ? [self getQuoteData:instrument] : data;
}

+ (void)addQuoteReceiver:(id<API_Event_QuoteDataStore>)delegate{
    
    if (delegate != nil) {
        if (quoteEventListenerArray == nil) {
            quoteEventListenerArray = [[NSMutableArray alloc] init];
        }

        @synchronized(quoteEventListenerArray){
            if (![quoteEventListenerArray containsObject:delegate]) {
                [quoteEventListenerArray addObject:delegate];
                        NSLog(@"adddddddd, %lu", (unsigned long)[quoteEventListenerArray count]);
            }
        }
    }
}

+ (void)removeQuoteReceiver:(id<API_Event_QuoteDataStore>)delegate{
    if (delegate != nil && [quoteEventListenerArray containsObject:delegate]) {
        @synchronized(quoteEventListenerArray){
            if ([quoteEventListenerArray containsObject:delegate]) {
                [quoteEventListenerArray removeObject:delegate];
            }
        }
    }
}

- (void)addSender{
    [NSThread detachNewThreadSelector:@selector(fireRecQuote) toTarget:self withObject:nil];
}

- (void)fireRecQuote{
    while (true) {
        JEDI_SYS_Try {
            if (isDestroy) {
                break;
            }
            [NSThread sleepForTimeInterval:0.5f];
            if (sendDic == nil || [sendDic count] == 0) {
                continue;
            }
            
            if (quoteEventListenerArray == nil || [quoteEventListenerArray count] == 0) {
                continue;
            }
            
            NSDictionary *dic = [sendDic copy];
            @synchronized(sendDic){
                [sendDic removeAllObjects];
            }
            
            @synchronized(quoteEventListenerArray){
                NSLog(@"sending");
                NSLog(@"listener count is : %lu", (unsigned long)[quoteEventListenerArray count]);
                for (id<API_Event_QuoteDataStore> listener in quoteEventListenerArray) {
                    //                    NSLog(@"class Name is %@", [listener class]);
                    for (CDS_PriceSnapShot *quoteData in [dic allValues]) {
                        [listener recQuoteData:quoteData];
                    }
                }
                dic = nil;
            }
            
        }JEDI_SYS_EndTry
    }
}

- (void)destroy{
    quoteDataStore = nil;
    [quoteEventListenerArray removeAllObjects];
    quoteEventListenerArray = nil;
    isDestroy = true;
    inited = false;
    [sendDic removeAllObjects];
    sendDic = nil;
}

@end
