//
//  OperationRecordsSave.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 16/6/14.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "OperationRecordsSave.h"
#import "JEDISystem.h"
#import "OperationRecords.h"
#import "TradeApi.h"
#import "ClientAPI.h"
#import "ShowAlert.h"

NSString *const OperationRecordsSaveFileName = @"OperationRecordsSaveFileName";

NSString *const OperationArrayKey = @"OperationArrayKey";

static OperationRecordsSave *instance = nil;

@interface OperationRecordsSave(){
    NSString *_fileName;
    NSMutableArray *_operationArray;
}

@end

@implementation OperationRecordsSave

+ (OperationRecordsSave *)getInstance {
    if (instance == nil) {
        instance = [[OperationRecordsSave alloc] initWithFileName:OperationRecordsSaveFileName];
    }
    return instance;
}

- (id)initWithFileName:(NSString *)fileName{
    if (self = [super init]) {
        _fileName = fileName;
        [self loadUserConfigSaveData];
    }
    return self;
}

- (void)saveConfigData {
    [self writeUserConfigPlist:_fileName];
}

-(void) loadUserConfigSaveData {
    JEDI_SYS_Try {
        NSString *dataPath = NSTemporaryDirectory();
        dataPath = [NSString stringWithFormat:@"%@%@", dataPath, _fileName];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
        NSArray *array  = [dictionary objectForKey:OperationArrayKey];
        _operationArray = [[NSMutableArray alloc] init];
        for (NSData *data in array) {
            OperationRecords *or = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [_operationArray addObject:or];
        }
    }JEDI_SYS_EndTry
}

- (void)addOpeRecords:(int)type subType:(int)subType {
    OperationRecords *record = [[OperationRecords alloc] init];
    [record setAccount:[[ClientAPI getInstance] getAccount]];
    [record setAeid:[[ClientAPI getInstance] aeid]];
    [record setType:type];
    [record setSubType:subType];
    [record setOptTime:[NSDate new]];
    [record setDeviceType:14];// iphone
    if (_operationArray == nil) {
        _operationArray = [[NSMutableArray alloc] init];
    }
    [_operationArray addObject:record];
    [self saveConfigData];
}

- (void)sendToServer {
    [NSThread detachNewThreadSelector:@selector(sendThread)
                             toTarget:self
                           withObject:nil];
   
}

- (void)sendThread {
    int time = 3;
    while (time > 0) {
        time--;
        TradeResult *result = [[TradeApi getInstance] saveOptRecords:_operationArray];
        if ([result succeed]) {
            [_operationArray removeAllObjects];
            [self saveConfigData];
            return;
        }
        [NSThread sleepForTimeInterval:3];
    }
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    JEDI_SYS_Try {
        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
        
        NSMutableArray *operationArchiveArray = [[NSMutableArray alloc] init];
        for (OperationRecords *or in _operationArray) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:or];
            [operationArchiveArray addObject:data];
        }
        
        [dictPlist setObject:operationArchiveArray    forKey:OperationArrayKey];
        
        NSString *plistPath = NSTemporaryDirectory();
        plistPath = [NSString stringWithFormat:@"%@%@", plistPath, plistFile];
        
        if(![dictPlist writeToFile:plistPath atomically:YES]){
            NSLog(@"write user config file failed.");
        }
    } JEDI_SYS_EndTry
}

@end
