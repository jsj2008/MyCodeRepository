//
//  SDGJJ.m
//  SD
//
//  Created by 余艾星 on 17/3/4.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import "SDGJJ.h"
#import "SDFields.h"

@implementation SDGJJ


- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *specModel = [NSMutableArray array];
        for (NSDictionary *dict in self.fields) {
            
            SDFields *spec = [SDFields fieldsWithDict:dict];
            [specModel addObject:spec];
        }
        
        self.fields = specModel;
    }
    
    return self;
}

+ (instancetype)gJJWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (void)getGJJInfoWithChannelType:(NSString *)channelType channelCode:(NSString *)channelCode finishedBlock:(GJJFinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{
                           @"channelType":channelType,
                           @"channelCode":channelCode
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/loanAndSocial/initLogin" finishedBlock:^(id object) {
        
        NSDictionary *dict = object[@"data"];
        
        NSString *taskId = dict[@"taskId"];
        
        NSArray *array = dict[@"varFields"];
        
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            
            FDLog(@"dict - %@",dict);
            
            SDGJJ *spec = [SDGJJ gJJWithDict:dict];
            [model addObject:spec];
        }
        
        
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(model,taskId);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
    
    
    
}

+ (void)getGJJVerifyCodeWithChannelType:(NSString *)channelType channelCode:(NSString *)channelCode taskId:(NSString *)taskId finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *dict = @{
                           @"channelType":channelType,
                           @"channelCode":channelCode,
                           @"taskId":taskId
                           };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    [manager postWithURLString:@"/loanAndSocial/getVertifyCodeImg" finishedBlock:^(id object) {
        
        
        
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(object);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
    
    
}

//(社保、公积金、学信网）校验并获取数据接口/loanAndSocial/handleData
+ (void)submitGJJInfoWithChannelType:(NSString *)channelType channelCode:(NSString *)channelCode taskId:(NSString *)taskId verifyCode:(NSString *)verifyCode inputElementStr:(NSString *)inputElementStr finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{

    NSDictionary *d = @{
                        @"channelType":channelType,
                        @"channelCode":channelCode,
                        @"taskId":taskId,
                        @"mobile":[FDUserDefaults objectForKey:FDUserAccount],
                        @"inputElementStr":inputElementStr
                        };
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:d];
    
    

    if (verifyCode.length > 0) {
    
        [dict setObject:verifyCode forKey:@"verifyCode"];
    }
    
    
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    [manager setManeger:manager dict:dict];
    
    FDLog(@"dict- %@",dict);
    
    
    
    [manager postWithURLString:@"/loanAndSocial/handleData" finishedBlock:^(id object) {
        
        
        
        [FDReminderView showWithString:object[@"msg"]];
        
        if (finishedBlock){
            
            //返回给模型
            finishedBlock(object);
            
        }
        
    } parameters:dict failuredBlock:^(id object) {
        
//        [FDReminderView showWithString:object[@"msg"]];
        
        [FDReminderView showWithString:@"认证失败"];
        
        if (failuredBlock) {
            
            //返回给模型
            failuredBlock(object);
        }
    }];
}

@end
