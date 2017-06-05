//
//  SDFeedBackModel.m
//  SD
//
//  Created by LayZhang on 2017/6/1.
//  Copyright © 2017年 ZXKJ. All rights reserved.
//

#import "SDFeedBackModel.h"
#import "AliyunOSSDemo.h"
#import "SDUserInfo.h"
#import "SDNetworkTool.h"

@implementation SDFeedBackModel

+ (NSString *)uploadQuestionImageArray:(NSArray *)imageArray {
    return [[AliyunOSSDemo sharedInstance] uploadQuestionImageWithImageArray:imageArray];
}

+ (void)commitUserFeedBackWith:(NSArray *)imageArray
               feedBackContent:(NSString *)content
          feedBackcontentTitle:(NSString *)contentTitle {
    
    NSString *imageString = @"";
    if (imageArray) {
        imageString = [self uploadQuestionImageArray:imageArray];
    }
    
    SDUserInfo *user = [SDUserInfo getUserInfo];
    
    NSDictionary *parameters = @{
                                 @"userId":user.ID,
                                 @"imge":imageString,
                                 @"content":content,
                                 @"title":contentTitle,
                                 };
    
    SDNetworkTool *manager = [SDNetworkTool getManager];
    
    
    [manager setManeger:manager dict:parameters];
    
    [manager postWithURLString:@"/problem/save" finishedBlock:^(id object) {
        
        NSString *str = object[@"msg"];
        
        if ([str containsString:@"成功"]) {
            
            [FDReminderView showWithString:@"反馈成功"];
            
            [SDNotificationCenter postNotificationName:SDUserFeedBackSuccessNotification object:nil];
        }else{
            
            [FDReminderView showWithString:@"反馈失败"];
        }
        
    } parameters:parameters failuredBlock:^(id object) {
        [FDReminderView showWithString:@"反馈失败"];
    }];
}

@end
