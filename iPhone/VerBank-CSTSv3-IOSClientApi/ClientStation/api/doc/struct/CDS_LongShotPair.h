//
//  CDS_LongShotPair.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/7/1.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"

@interface CDS_LongShotPair : CommDocBasicStruct
@property NSString* long_ccy;
@property double    long_amount;
@property NSString* short_ccy;
@property double    short_amount;
@property NSString* ccy1;
@property NSString* ccy2;
@end
