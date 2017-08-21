//
//  ITDetailContentModel.h
//  YouCai
//
//  Created by marco on 5/28/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol ITDetailContentModel

@end

@interface ITDetailContentModel : BaseModel
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString<Optional> *image;
@property (nonatomic, strong) NSString<Optional> *text;
@property (nonatomic, assign) CGFloat  ar;
@end
