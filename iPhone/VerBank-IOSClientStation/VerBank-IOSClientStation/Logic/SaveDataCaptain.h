//
//  SaveDataCaptain.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/7/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveDataCaptain : NSObject
@property (nonatomic, retain)NSString *identifyNumber;
@property (nonatomic, retain)NSString *password;
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain)NSString *notFirstLaunch;

+ (SaveDataCaptain *)getInstance;

- (id)initWithFileName:(NSString *)fileName;
- (Boolean)isSaveConfigData;
- (void)setIsSaveConfigData:(NSString *)isSave;

- (void)saveConfigData;

@end
