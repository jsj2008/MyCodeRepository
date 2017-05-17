//
//  InstWarnConfig.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/9/7.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface InstWarnConfig : NSObject

+ (InstWarnConfig *)getInstance;

- (double)getWarningPerc;

@end
