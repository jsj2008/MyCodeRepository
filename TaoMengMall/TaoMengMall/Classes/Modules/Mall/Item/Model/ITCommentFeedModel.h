//
//  ITCommentFeedModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ITCommentFeedModel

@end

@interface ITCommentFeedModel : BaseModel

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *skuDesc;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<Optional> *images;
@end
