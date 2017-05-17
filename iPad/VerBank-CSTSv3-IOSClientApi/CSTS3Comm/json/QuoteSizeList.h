//
//  QuoteSizeList.h
//  IOSClientApiTester
//
//  Created by felix on 7/25/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface QuoteSizeList : AbstractJsonData

-(id)               init;

-(NSMutableArray *) getSizes; // QuoteSizeData[]
-(void)             setSizes:(NSMutableArray *) sizes;

@end
