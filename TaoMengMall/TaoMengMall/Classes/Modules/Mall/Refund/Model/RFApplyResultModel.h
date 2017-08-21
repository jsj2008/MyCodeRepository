//
//  RFApplyResultModel.h
//  YouCai
//
//  Created by marco on 6/13/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"
#import "RFApplyIdValueModel.h"

@interface RFApplyResultModel : BaseModel

@property (nonatomic, strong)NSArray<RFApplyIdValueModel> *types;
@property (nonatomic, strong)NSArray<RFApplyIdValueModel> *causes;
//@property (nonatomic, strong)NSArray<RFApplyIdValueModel> *ways;
@property (nonatomic, strong)NSString *maxRefundAmount;

@end
