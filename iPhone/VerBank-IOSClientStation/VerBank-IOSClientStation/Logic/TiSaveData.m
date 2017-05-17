//
//  TiSaveData.m
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/12/4.
//  Copyright © 2015年 zhanglei. All rights reserved.
//

#import "TiSaveData.h"
#import "JEDISystem.h"

NSString *const TiSaveDataFileName = @"TiSaveDataFileName";

NSString *const TiMap = @"TiMap";
NSString *const TiClientMap = @"TiClientMap";

static TiSaveData *instance = nil;

@interface TiSaveData(){
    NSString *_fileName;
}

@end

@implementation TiSaveData

@synthesize tiMap;
@synthesize tiClientMap;


+ (TiSaveData *)getInstance {
    if (instance == nil) {
        instance = [[TiSaveData alloc] initWithFileName:TiSaveDataFileName];
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
        
        self.tiMap = [[NSMutableDictionary alloc] initWithDictionary:[dictionary objectForKey:TiMap]];
        self.tiClientMap = [[NSMutableDictionary alloc] initWithDictionary:[dictionary objectForKey:TiClientMap]];
        
    }JEDI_SYS_EndTry
}

-(void) writeUserConfigPlist:(NSString *) plistFile{
    JEDI_SYS_Try {
        NSMutableDictionary *dictPlist = [[NSMutableDictionary alloc ] init];
        
//        [self.tiMap removeAllObjects];
        [dictPlist setObject:self.tiMap    forKey:TiMap];
        [dictPlist setObject:self.tiClientMap    forKey:TiClientMap];
        
        NSString *plistPath = NSTemporaryDirectory();
        plistPath = [NSString stringWithFormat:@"%@%@", plistPath, plistFile];
        
        if(![dictPlist writeToFile:plistPath atomically:YES]){
            NSLog(@"write user config file failed.");
        }
    } JEDI_SYS_EndTry
}


@end
