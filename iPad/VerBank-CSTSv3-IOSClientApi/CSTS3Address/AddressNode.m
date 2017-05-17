//
//  AddressNode.m
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import "AddressNode.h"

@implementation AddressNode

//----------------------------------------------------
- (id)      init
{
    self = [super init];
    
    if(self != nil)
    {
        self.strName = nil;
        self.strIp = nil;
        self.nPort = 0;
        
        self.nWeight = INT_MAX;
        self.nPing = LONG_MAX;
    }
    
    return self;
}

//----------------------------------------------------
- (BOOL)    isGood
{
    if(self.nPing < 0) return false;
    if(self.nPing == LONG_MAX) return false;
    if(self.nWeight < 0 || self.nWeight > 100) return false;
    
    return true;
}

//----------------------------------------------------
- (int)     compareTo:(AddressNode *) node
{
    if(self.nPing < 0 || self.nWeight < 0){
        return NSOrderedDescending;
    }else if(node.nPing < 0 || node.nWeight < 0){
        return NSOrderedAscending;
    }
    
    int asEqulePingGap = 2;
    
    if(ABS(self.nPing - node.nPing) < asEqulePingGap)
    {
        return (self.nWeight > node.nWeight) ? NSOrderedDescending : NSOrderedAscending;
    }else{
        return (self.nPing   > node.nPing  ) ? NSOrderedDescending : NSOrderedAscending;
    }
}

//----------------------------------------------------
- (NSString *) toString
{
    return [NSString stringWithFormat:@"%@, %@, %d, %ld, %d", self.strName, self.strIp, self.nPort, self.nPing, self.nWeight];
}

@end
