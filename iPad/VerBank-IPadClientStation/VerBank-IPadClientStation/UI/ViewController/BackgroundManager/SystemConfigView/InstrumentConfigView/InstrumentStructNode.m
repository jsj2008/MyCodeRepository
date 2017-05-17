//
//  InstrumentStructNode.m
//  VerBank-IPadClientStation
//
//  Created by Allone on 16/4/18.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "InstrumentStructNode.h"

@implementation InstrumentStructNode

@synthesize instrumentName;
@synthesize selectType;

- (id)initWithInstrument:(NSString *)instrument selectType:(InstrumentSelectType)type {
    if (self = [super init]) {
        self.instrumentName = instrument;
        self.selectType = type;
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:instrumentName forKey:@"instrumentName"];
    [aCoder encodeObject:[NSNumber numberWithInt:selectType] forKey:@"selectType"];
}

//将对象解码(反序列化)
-(id) initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.instrumentName =[aDecoder decodeObjectForKey:@"instrumentName"];
        self.selectType = [[aDecoder decodeObjectForKey:@"selectType"] intValue];
    }
    return (self);
}

@end
