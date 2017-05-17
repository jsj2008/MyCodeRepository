//
//  QuoteRequest.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/24.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AbstractJsonData.h"

@interface QuoteRequest : AbstractJsonData

-(id)               init;

-(NSMutableArray *) getInstruments;
-(void)             setInstruments:(NSMutableArray *)instruments;

@end
