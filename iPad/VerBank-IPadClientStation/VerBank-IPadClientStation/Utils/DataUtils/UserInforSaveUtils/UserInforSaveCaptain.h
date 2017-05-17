//
//  UserInforSaveCaptain.h
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/2/23.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInforSaveCaptain : NSObject
@property (nonatomic, retain)NSString *identifyNumber;
@property (nonatomic, retain)NSString *password;
@property (nonatomic, retain)NSString *userName;
@property (nonatomic, retain)NSString *notFirstLaunch;

+ (UserInforSaveCaptain *)getInstance;

- (id)initWithFileName:(NSString *)fileName;
- (Boolean)isSaveConfigData;
- (void)setIsSaveConfigData:(NSString *)isSave;

- (void)saveConfigData;
@end
