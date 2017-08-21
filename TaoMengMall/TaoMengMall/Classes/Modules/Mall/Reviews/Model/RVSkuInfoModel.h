//
//  RVSkuInfoModel.h
//  Refound
//
//  Created by marco on 6/8/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol RVSkuInfoModel <NSObject>



@end


@interface RVSkuInfoModel : BaseModel
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *skuDesc;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString<Optional> *oPrice;
@property (nonatomic, strong) NSString<Optional> *link;
@end
