//
//  SDNetworkTool.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/10.
//  Copyright © 2017年 tyiti. All rights reserved.
//

//#define BaseURLString @"http://116.62.26.225:8080"
//
//#ifdef DEBUG
//
//#else
//
////#define BaseURLString @"http://116.62.26.225:8080"
//
//
//#define BaseURLString @"https://api.shandaixia.com.cn:9191"
//
//#endif

#import <AFNetworking/AFNetworking.h>

static NSString * const BaseURLString = @"http://10.60.20.56:8080";
//static NSString * const BaseURLString = @"http://116.62.26.225:8080";
//static NSString * const BaseURLString = @"https://api.shandaixia.com.cn:9191";

//static NSString * const BaseURLString = @"http://10.60.20.86:81";
//static NSString * const BaseURLString = @"http://10.60.20.90:18080";

//成功时的block
typedef void(^FinishedBlock)(id object);

//失败时的block
typedef void(^FailuredBlock)(id object);

@interface SDNetworkTool : AFHTTPSessionManager

+ (SDNetworkTool *)getManager;

- (void)postWithURLString:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock parameters:(NSDictionary *) parameters failuredBlock:(FailuredBlock)failuredBlock;

- (void)getWithURLString:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock failuredBlock:(FailuredBlock)failuredBlock;

//上传单张图片
- (void)postImage:(NSString *)urlString parameters:(id)parameters image:(UIImage *)image;

- (void)setManeger:(SDNetworkTool *)manager dict:(NSDictionary *)dict;

@end
