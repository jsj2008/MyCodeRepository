//
//  RFDetailResultModel.h
//  Refound
//
//  Created by marco on 6/7/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseModel.h"

@interface RFSubmitInfoModel : BaseModel

@property (nonatomic, strong)NSString *orderId;
@property (nonatomic, strong)NSString *refundTypeId;
@property (nonatomic, strong)NSString *reasonId;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *refundModeId;
@property (nonatomic, strong)NSString<Optional> *desc;
@property (nonatomic, strong)NSArray<Optional> *images;

@end
