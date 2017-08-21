//
//  CommentListResultModel.h
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "CommentDSRModel.h"
#import "CommentInfoModel.h"

@interface CommentListResultModel : BaseModel


@property (nonatomic, strong)CommentDSRModel *dsr;
@property (nonatomic, strong)CommentInfoModel *comments;
@end
