//
//  AreaModel.h
//  YouCai
//
//  Created by marco on 6/12/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol AreaModel <NSObject>

@end


@interface AreaModel : BaseModel
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString <Optional>*code;
@end
