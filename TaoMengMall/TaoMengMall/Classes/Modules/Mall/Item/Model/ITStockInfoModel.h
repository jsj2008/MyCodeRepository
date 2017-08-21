//
//  ITStockInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ITStockInfoModel

@end

@interface ITStockInfoModel : BaseModel

@property (nonatomic, strong) NSString *image;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *skuId;

@end
