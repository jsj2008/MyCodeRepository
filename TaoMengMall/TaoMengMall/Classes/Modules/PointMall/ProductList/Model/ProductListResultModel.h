//
//  CategoryResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "WallModel.h"
#import "PMCatesModel.h"
#import "PMListItemMOdel.h"

@protocol ProductListResultModel

@end

@interface ProductListResultModel : BaseModel

//@property (nonatomic, strong) WallModel *items;

@property (nonatomic,strong) NSArray<PMListItemMOdel,Optional> *list;

@property (nonatomic,strong) NSArray<PMCatesModel,Optional> *cates;

@property (nonatomic,copy) NSString<Optional> *wp;

@property (nonatomic,assign) BOOL isEnd;


@end
