//
//  SDMassages.m
//  SD
//
//  Created by 余艾星 on 17/3/2.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDMassages.h"
#import "SDUserInfo.h"

@implementation SDMassages

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)massageWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
    
}


+ (void)getMassages:(NSInteger)pageNo finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

 
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *dict = @{
                           @"userId":user.ID,
                           @"pageNo":[NSString stringWithFormat:@"%@",@(pageNo)],
                           @"pageSize":pageSize
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/push/pushInfo";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        NSArray *array = object[@"data"];
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            SDMassages *spec = [SDMassages massageWithDict:dict];
            [model addObject:spec];
            
            FDLog(@"dict - %@",dict);
        }
        
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(model);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
        
    }];
    
}

//37、推送状态（是否已读）（/ push/ updateStatus）
+ (void)readMassage:(SDMassages *)massage finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    
    
    NSDictionary *dict = @{
                           @"id":massage.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/push/updateStatus";
    
    FDLog(@"dict - %@",dict);
    
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        FDLog(@"massage - delete - %@",object);
        
        if (finishedBlock) {
            finishedBlock(object);
        }
        
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            failuredBlock(object);
        }
    }];
    
}

//38、推送状态（删除 ）（/ push/ deleteStatus）
+ (void)deleteMassage:(SDMassages *)massage finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{
                           @"id":massage.ID
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    NSString *urlString = @"/push/deleteStatus";
    
    [manager postWithURLString:urlString finishedBlock:^(id object) {
        
        FDLog(@"massage - delete - %@",object);
        
        if (finishedBlock) {
            finishedBlock(object);
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            failuredBlock(object);
        }
    }];
}


@end
