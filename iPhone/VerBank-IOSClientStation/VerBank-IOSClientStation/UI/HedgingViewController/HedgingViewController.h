//
//  HedgingViewController.h
//  VerBank-IOSClientStation
//
//  Created by Allone on 15/8/24.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "LeftViewController.h"

static NSString *_instrumentName;

@interface HedgingViewController : LeftViewController

+ (void)setInstrumentName:(NSString *)instrument;
+ (NSString *)getInstrumentName;

@end
