//
//  ShopResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ShopInfoModel.h"
#import "ShopTabModel.h"
#import "ShopItemsModel.h"
#import "WallModel.h"
#import "ShareInfoModel.h"

@protocol ShopResultModel

@end

@interface ShopResultModel : BaseModel

@property (nonatomic, strong) ShopInfoModel<Optional> *shopInfo;
@property (nonatomic, strong) NSArray<ShopTabModel> *tab;
@property (nonatomic, strong) ShopItemsModel<Optional> *items;
@property (nonatomic,strong) ShareInfoModel<Optional> *share;

@end
