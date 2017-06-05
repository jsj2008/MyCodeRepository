//
//  SDNetworkTool.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/10.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDNetworkTool.h"


@implementation SDNetworkTool

static SDNetworkTool *_instance;


+ (instancetype)sharedHMNetWorkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        
        NSLog(@"BaseURLString - %@",BaseURLString);
        
        
        
        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        
        _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"application/json"];
        
        //        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
    });
    
    return _instance;
}

+ (SDNetworkTool *)getManager{
    
    
    SDNetworkTool *manager = [SDNetworkTool sharedHMNetWorkTool];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    [manager.requestSerializer setValue:@"0bca3e8e2baa42218040c5dbf6978f315e104e5c" forHTTPHeaderField:@"secretKey"];
    
    [manager.requestSerializer setValue:@"699b9305418757ef9a26e5a32ca9dbfb" forHTTPHeaderField:@"accessKey"];
    
    //15355315452
    
    return manager;
}

- (void)getWithURLString:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock{
    
//    NSString *url = [NSString stringWithFormat:@"%@%@",BaseURLString,URLString];
    //self就是单例
    
    [self GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if (finishedBlock) {
            
            //返回给模型
            finishedBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *str = [[NSString alloc] initWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        FDLog(@"str - %@",str);
        
        failuredBlock(error);
        
    }];
    
    
}

- (void)postWithURLString:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock parameters:(NSDictionary *) parameters failuredBlock:(FailuredBlock)failuredBlock{
    //self就是单例
    
    
    [self POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        FDLog(@"url - %@",URLString);
        
        if (finishedBlock) {
            //返回给模型
            
            finishedBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *str = [[NSString alloc] initWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        FDLog(@"str - %@",str);
        
        failuredBlock(error);
        
    }];
    
  
    
}

//上传单张图片
- (void)postImage:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image{
    
    
    [self POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImagePNGRepresentation(image);
        
        if (imageData == nil) {
            
            imageData = UIImageJPEGRepresentation(image,1.0);
        }
        
//        NSString *fileName = [NSString stringWithFormat:@"%@.png",[NSString getTimestamp]];
        
        [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:@"1.png" mimeType:@"image/png"];

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [FDReminderView showWithString:@"上传成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [FDReminderView showWithString:@"上传失败"];
        
        NSString *str = [[NSString alloc] initWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        FDLog(@"上传失败 - %@",str);

    }];
    
}

- (void)setManeger:(SDNetworkTool *)manager dict:(NSDictionary *)dict{
    
    NSString *sortString = [dict sort:dict];
    NSString *reqTime = [FDDateFormatter getCurrentTime];
    NSString *secretKey = @"0bca3e8e2baa42218040c5dbf6978f315e104e5c";
    NSString *sign = [NSString stringWithFormat:@"%@%@%@",secretKey,reqTime,sortString];
    NSString *uuid = [NSString getUUID];
    
    FDLog(@"reqTime - %@ ,sign - %@",reqTime,sign);
    
    FDLog(@"UUID - %@", uuid);
    
    [manager.requestSerializer setValue:reqTime forHTTPHeaderField:@"reqTime"];
    
    [manager.requestSerializer setValue:[[sign md5] md5] forHTTPHeaderField:@"sign"];
    
//    [manager.requestSerializer setValue:uuid forHTTPHeaderField:@"UUID"];
    
}


@end













