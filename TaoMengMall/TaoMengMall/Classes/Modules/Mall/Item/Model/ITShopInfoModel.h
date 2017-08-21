//
//  ITShopInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "DsrModel.h"

@protocol ITShopInfoModel

@end

@interface ITShopInfoModel : BaseModel

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *discountInfo;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *favCount;
@property (nonatomic, strong) NSString *itemCount;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) DsrModel *dsr;

@end
