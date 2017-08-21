//
//  MCCategoryResultModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/9.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MCCategoryModuleModel.h"
#import "MCCategorySiftModel.h"

@interface MCCategoryResultModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *title;

@property (nonatomic, strong) WallModel *items;

@property (nonatomic,strong) NSArray<Optional,MCCategorySiftModel> *sifts;
@property (nonatomic,strong) NSArray<Optional,MCCategoryModuleModel> *categories;


@end

