//
//  CommentDSRItemModel.h
//  YouCai
//
//  Created by marco on 6/14/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
@protocol CommentDSRItemModel
@end

@interface CommentDSRItemModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *v;
@end
