//
//  RFApplyIdValueModel.h
//  YouCai
//
//  Created by marco on 6/13/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@protocol RFApplyIdValueModel <NSObject>

@end

@interface RFApplyIdValueModel : BaseModel
@property (nonatomic, assign)NSInteger typeId;
@property (nonatomic, strong)NSString *value;
@end
