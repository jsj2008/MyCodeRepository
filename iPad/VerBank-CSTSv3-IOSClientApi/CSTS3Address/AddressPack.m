//
//  AddressPack.m
//  IOSClientStation
//
//  Created by felix on 8/8/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import "AddressPack.h"
#import "JEDISystem.h"
#import "AddressNode.h"

@implementation AddressPack

-(id) init
{
    self = [super init];
    if(self != nil)
    {
        self.isDemo = false;
        self.strPreMark = @"";
        self.nodeArray = nil;
    }
    
    return self;
}

-(void) dealloc
{
    if(self.nodeArray != nil){
        [self.nodeArray removeAllObjects];
    }
    
    [self setNodeArray:nil];
    [self setStrPreMark:nil];
}

-(void) toString
{
    //NSLog(@"--------Pack %@---------isDemo %@----", self.strPreMark, (self.isDemo ? @"YES" : @"NO"));
    
    for(AddressNode * node in self.nodeArray)
    {
        [JEDISystem log:[node toString]];
    }
}

@end
