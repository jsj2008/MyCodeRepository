//
//  JsonData4Fix.h
//  JEDIv7-CSTSv3-IOSClientApi
//
//  Created by felix on 7/18/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "BasicFixData.h"
#import "AbstractJsonData.h"

@interface JsonData4Fix : BasicFixData
{
@private
    AbstractJsonData * mJsonData;
    NSString         * mJsonString;
}

- (id) init;

- (void)  setJsonData:(AbstractJsonData *) data;
- (AbstractJsonData *)  getJsonData;

- (NSString *) getJsonString;

#pragma mark Override

- (NSData *) format;
- (BOOL)     parse;

@end
