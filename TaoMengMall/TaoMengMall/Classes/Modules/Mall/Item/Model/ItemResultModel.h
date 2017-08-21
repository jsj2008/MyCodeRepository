//
//  ItemResultModel.h
//  HongBao
//
//  Created by Ivan on 16/1/31.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

#import "ItemInfoModel.h"
#import "ITShopInfoModel.h"
#import "ITCommentInfoModel.h"
#import "ShareInfoModel.h"
#import "ITRecommendsModel.h"
#import "ODCashBackModel.h"
@protocol ItemResultModel

@end

@interface ItemResultModel : BaseModel

@property (nonatomic, strong) ItemInfoModel *itemInfo;
@property (nonatomic, strong) ITShopInfoModel<Optional> *shopInfo;
@property (nonatomic, strong) ITCommentInfoModel<Optional> *commentInfo;
@property (nonatomic, strong) ShareInfoModel<Optional> *share;
@property (nonatomic, strong) ITRecommendsModel<Optional> *recommend;
@property (nonatomic,copy) NSString<Optional> *serviceCharge;
@property (nonatomic,copy) NSString<Optional> *cashback;
@property (nonatomic,copy) NSString<Optional> *quotaDesc;
@end
