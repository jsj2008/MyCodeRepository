//
//  ODShopInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ODShopInfoModel

@end

@interface ODShopInfoModel : BaseModel

@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString<Optional> *shopLink;
@end
