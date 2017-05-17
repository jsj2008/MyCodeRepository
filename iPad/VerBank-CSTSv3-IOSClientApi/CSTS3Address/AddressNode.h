//
//  AddressNode.h
//  JEDIv7-CSTSv3-ClientAPI
//
//  Created by baolin on 13/5/17.
//  Copyright (c) 2013年 wangyubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressNode : NSObject

//----------------------------------------------------------------
@property (strong, nonatomic) NSString * strName;
@property (strong, nonatomic) NSString * strIp;

@property (nonatomic)         int        nPort;
@property (nonatomic)         int        nWeight;
@property (nonatomic)         long       nPing;

//----------------------------------------------------------------
- (id)          init;

- (BOOL)        isGood;
- (int)         compareTo:(AddressNode *) node;

- (NSString *)  toString;

@end
