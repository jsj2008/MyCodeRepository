//
//  SDShared.h
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDShared : NSObject

@property (nonatomic, copy) NSString *gmtCreate;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)sharedWithDict:(NSDictionary *)dict;

+ (void)getSharedfinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end




