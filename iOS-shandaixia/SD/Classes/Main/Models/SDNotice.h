//
//  SDNotice.h
//  SD
//
//  Created by 余艾星 on 17/3/11.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDNotice : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *pushType;

@property (nonatomic, copy) NSString *targetUser;


@property (nonatomic, copy) NSString *gmtCreate;
@property (nonatomic, copy) NSString *gmtModify;

@property (nonatomic, copy) NSString *adminTest;

@property (nonatomic, copy) NSString *gmtModifyUser;
@property (nonatomic, copy) NSString *pushUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)noticeWithDict:(NSDictionary *)dict;


//2、公告信息（/ push/ findNotice）
+ (void)noticeFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;


@end
