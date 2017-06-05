//
//  SDNotice.m
//  SD
//
//  Created by 余艾星 on 17/3/11.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDNotice.h"

@implementation SDNotice

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)noticeWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
    
}


//2、公告信息（/ push/ findNotice）
+ (void)noticeFinishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:[[NSDictionary alloc] init]];
    
    [manager postWithURLString:@"/push/findNotice" finishedBlock:^(id object) {
        
        
        NSDictionary *dict = object[@"data"];
        
        
        SDNotice *notice = [SDNotice noticeWithDict:dict];
        
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(notice);
        }
        
    } parameters:nil failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
}


@end
