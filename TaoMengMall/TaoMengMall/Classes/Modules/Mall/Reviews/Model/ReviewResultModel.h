//
//  ReviewResultModel.h
//  Refound
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "RVSkuInfoModel.h"

@interface ReviewResultModel : BaseModel

@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopLogo;
@property (nonatomic, strong) NSArray<RVSkuInfoModel,Optional> *skuInfos;
@end
