//
//  CommentInfoModel.h
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "CommentFeedModel.h"

@interface CommentInfoModel : BaseModel

@property (nonatomic, strong) NSArray<CommentFeedModel> *list;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString *wp;
@end
