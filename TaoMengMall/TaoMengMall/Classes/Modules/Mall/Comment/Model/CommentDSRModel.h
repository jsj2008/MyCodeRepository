//
//  CommentDSRModel.h
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "CommentDSRItemModel.h"

@interface CommentDSRModel : BaseModel
@property (nonatomic, strong) CommentDSRItemModel *qb;
@property (nonatomic, strong) CommentDSRItemModel *ms;
@property (nonatomic, strong) CommentDSRItemModel *zl;
@property (nonatomic, strong) CommentDSRItemModel *jg;
@end
