//
//  CommentRequest.h
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseRequest.h"
#import "CommentListResultModel.h"

@interface CommentRequest : BaseRequest


+ (void)getCommentListWithParams:(NSDictionary *)params success:(void(^)(CommentListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

+ (void)getCommentListMoreWithParams:(NSDictionary *)params success:(void(^)(CommentListResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure;

@end
