//
//  CDS_PriceShift.h
//  VerBank-CSTSv3-IOSClientApi
//
//  Created By Zhanglei on 15/6/30.
//  Copyright (c) 2015年 allone. All rights reserved.
//

#import "CommDocBasicStruct.h"

@interface CDS_PriceShift : CommDocBasicStruct

@property NSString* instrument;
@property double    bidShift;
@property double    askShift;

@end
