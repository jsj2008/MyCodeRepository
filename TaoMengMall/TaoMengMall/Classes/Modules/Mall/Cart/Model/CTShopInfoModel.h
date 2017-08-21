//
//  CTShopInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CTDiscountInfoModel.h"

@protocol CTShopInfoModel

@end

@interface CTShopInfoModel : BaseModel

@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) CTDiscountInfoModel<Optional> *discountInfo;
@property (nonatomic, strong) NSString<Optional> *logo;
@property (nonatomic, strong) NSString<Optional> *link;

//仅用于本地
//@property (nonatomic, strong) NSString<Ignore> *remark;

@end

