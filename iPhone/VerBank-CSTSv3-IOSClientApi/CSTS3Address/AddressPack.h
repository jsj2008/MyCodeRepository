//
//  AddressPack.h
//  IOSClientStation
//
//  Created by felix on 8/8/13.
//  Copyright (c) 2013 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressPack : NSObject

@property(nonatomic, strong) NSMutableArray * nodeArray;
@property(nonatomic, strong) NSString       * strPreMark;
@property(nonatomic)         Boolean          isDemo;

-(id)   init;

-(void) toString;

@end
