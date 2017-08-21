//
//  CommentInfoModel.h
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
@protocol CommentFeedModel
@end

@interface CommentFeedModel : BaseModel
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *skuDesc;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray<Optional> *images;
@end
