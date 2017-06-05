//
//  SDMassages.h
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

typedef enum {
    
    SDMassageStatusUnRead = 1,
    SDMassageStatusRead
}SDMassageStatus;

#import <Foundation/Foundation.h>
#import "SDNetworkTool.h"

@interface SDMassages : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pushType;
@property (nonatomic, copy) NSString *pushUrl;
@property (nonatomic, copy) NSString *gmtCreate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) SDMassageStatus status;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)massageWithDict:(NSDictionary *)dict;


//获取消息
+ (void)getMassages:(NSInteger)pageNo finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//37、推送状态（是否已读）（/ push/ updateStatus）
+ (void)readMassage:(SDMassages *)massage;

//38、推送状态（删除 ）（/ push/ deleteStatus）
+ (void)deleteMassage:(SDMassages *)massage;


//37、推送状态（是否已读）（/ push/ updateStatus）
+ (void)readMassage:(SDMassages *)massage finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//38、推送状态（删除 ）（/ push/ deleteStatus）
+ (void)deleteMassage:(SDMassages *)massage finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

@end








