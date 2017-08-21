//
//  RFHistoryResultModel.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "RefundInfoModel.h"

@interface RFHistoryResultModel : BaseModel

@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *expireTime;
@property (nonatomic, strong) NSArray<RefundInfoModel,Optional> *refundInfos;
@end
