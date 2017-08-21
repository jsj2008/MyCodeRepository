//
//  ITCommentInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ITCommentFeedModel.h"

@protocol ITCommentInfoModel

@end

@interface ITCommentInfoModel : BaseModel

@property (nonatomic, strong) NSString *cmtCount;
@property (nonatomic, strong) NSArray<ITCommentFeedModel> *comments;
@property (nonatomic, strong) NSString *link;

@end
