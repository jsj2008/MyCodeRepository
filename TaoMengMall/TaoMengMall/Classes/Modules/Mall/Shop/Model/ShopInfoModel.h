//
//  ShopInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ShopInfoModel

@end

@interface ShopInfoModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *favCount;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, assign) CGFloat ar;
@property (nonatomic,strong) NSString<Optional> *quota;
@end
