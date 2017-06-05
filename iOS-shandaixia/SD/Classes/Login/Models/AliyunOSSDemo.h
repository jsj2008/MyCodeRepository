//
//  AliyunOSSDemo.h
//  SD
//
//  Created by 余艾星 on 17/2/23.
//  Copyright © 2017年 余艾星. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AliyunOSSDemo : NSObject

+ (instancetype)sharedInstance;

- (void)setupEnvironment;

- (void)runDemo;

- (NSString *)getDocumentDirectory;

- (void)uploadObjectAsyncWithName:(NSString *)name image:(UIImage *)image;

// 不想改原来代码， 赶时间
- (NSString *)uploadQuestionImageWithImageArray:(NSArray *)imageArray;

- (void)downloadObjectAsync;

- (void)resumableUpload;



@end
