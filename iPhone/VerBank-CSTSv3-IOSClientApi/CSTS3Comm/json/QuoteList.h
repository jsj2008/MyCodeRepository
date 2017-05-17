//
//  QuoteList.h
//  IOSClientApiTester
//
//  Created by felix on 7/25/13.
//  Copyright (c) 2013 allone. All rights reserved.
//

#import "AbstractJsonData.h"

@interface QuoteList : AbstractJsonData

-(id)               init;

-(NSMutableArray *) getQuotes; // QuoteData[]
-(void)             setQuotes:(NSMutableArray *) quotes;

@end
