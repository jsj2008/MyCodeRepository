//
//  CommentRequest.m
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "CommentRequest.h"

#define COMMENT_LIST_REQUEST_URL                        @"/mall_item/comment"
#define COMMENT_LIST_MORE_REQUEST_URL                   @"/mall_item/comment"


@implementation CommentRequest


+ (void)getCommentListWithParams:(NSDictionary *)params success:(void(^)(CommentListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:COMMENT_LIST_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        CommentListResultModel *commenteeResult = [[CommentListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(commenteeResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];

}

+ (void)getCommentListMoreWithParams:(NSDictionary *)params success:(void(^)(CommentListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:COMMENT_LIST_MORE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = nil;
        
        CommentListResultModel *commenteeResult = [[CommentListResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(commenteeResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}
@end
