//
//  TiSaveData.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSaveDataCaptain.h"
#import "JEDISystem.h"
#import "KChartSaveData.h"

NSString *const TiSaveDataFileName = @"TiSaveDataFileName";

NSString *const SaveDataNodeAKey = @"SaveDataNodeA";
NSString *const SaveDataNodeBKey = @"SaveDataNodeB";
NSString *const SaveDataNodeCKey = @"SaveDataNodeC";
NSString *const SaveDataNodeDKey = @"SaveDataNodeD";

NSString *const InstrumentAKey = @"InstrumentA";
NSString *const InstrumentBKey = @"InstrumentB";
NSString *const InstrumentCKey = @"InstrumentC";
NSString *const InstrumentDKey = @"InstrumentD";

static TiSaveDataCaptain *instance = nil;

@interface TiSaveDataCaptain(){
    NSString *_fileName;
}

@end

@implementation TiSaveDataCaptain

@synthesize saveDataNodeA;
@synthesize saveDataNodeB;
@synthesize saveDataNodeC;
@synthesize saveDataNodeD;

@synthesize instrumentA;
@synthesize instrumentB;
@synthesize instrumentC;
@synthesize instrumentD;

+ (TiSaveDataCaptain *)getInstance {
    if (instance == nil) {
        instance = [[TiSaveDataCaptain alloc] initWithFileName:TiSaveDataFileName];
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

-(void)loadUserConfigSaveData {
    JEDI_SYS_Try {
        NSString *dataPath = NSTemporaryDirectory();
        dataPath = [NSString stringWithFormat:@"%@%@", dataPath, _fileName];
        
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:dataPath];
        
        self.saveDataNodeA = [self unarchiveData:[dictionary objectForKey:SaveDataNodeAKey]];
        self.saveDataNodeB = [self unarchiveData:[dictionary objectForKey:SaveDataNodeBKey]];
        self.saveDataNodeC = [self unarchiveData:[dictionary objectForKey:SaveDataNodeCKey]];
        self.saveDataNodeD = [self unarchiveData:[dictionary objectForKey:SaveDataNodeDKey]];
        
        self.instrumentA = [dictionary objectForKey:InstrumentAKey];
        self.instrumentB = [dictionary objectForKey:InstrumentBKey];
        self.instrumentC = [dictionary objectForKey:InstrumentCKey];
        self.instrumentD = [dictionary objectForKey:InstrumentDKey];
        
    }JEDI_SYS_EndTry
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    JEDI_SYS_Try {
        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
        
        [dictPlist setObject:[self archiveData:self.saveDataNodeA]   forKey:SaveDataNodeAKey];
        [dictPlist setObject:[self archiveData:self.saveDataNodeB]   forKey:SaveDataNodeBKey];
        [dictPlist setObject:[self archiveData:self.saveDataNodeC]   forKey:SaveDataNodeCKey];
        [dictPlist setObject:[self archiveData:self.saveDataNodeD]   forKey:SaveDataNodeDKey];
        
        [dictPlist setObject:self.instrumentA forKey:InstrumentAKey];
        [dictPlist setObject:self.instrumentB forKey:InstrumentBKey];
        [dictPlist setObject:self.instrumentC forKey:InstrumentCKey];
        [dictPlist setObject:self.instrumentD forKey:InstrumentDKey];
        
        NSString *plistPath = NSTemporaryDirectory();
        plistPath = [NSString stringWithFormat:@"%@%@", plistPath, plistFile];
        
        if(![dictPlist writeToFile:plistPath atomically:YES]){
            NSLog(@"write user config file failed.");
        }
    } JEDI_SYS_EndTry
}

- (NSMutableDictionary *)archiveData:(NSDictionary *)saveDataNodeDictionary {
    NSMutableDictionary *archivedDataDic = [[NSMutableDictionary alloc] init];
    for (NSString *saveKey in [saveDataNodeDictionary allKeys]) {
        KChartSaveData *saveData = [saveDataNodeDictionary objectForKey:saveKey];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:saveData];
        [archivedDataDic setObject:data forKey:saveKey];
    }
    return archivedDataDic;
}

- (NSMutableDictionary *)unarchiveData:(NSDictionary *)saveDataNodeDictionary {
    NSMutableDictionary *unarchiveDataDic = [[NSMutableDictionary alloc] init];
    if (saveDataNodeDictionary != nil && [saveDataNodeDictionary count] != 0) {
        for (NSString *saveKey in [saveDataNodeDictionary allKeys]) {
            NSData *data = [saveDataNodeDictionary objectForKey:saveKey];
            KChartSaveData *saveData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [unarchiveDataDic setValue:saveData forKey:saveKey];
        }
    }
    return unarchiveDataDic;
}

@end
