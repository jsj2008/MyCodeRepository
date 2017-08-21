//
//  CategoryResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "CategoryModel.h"
#import "WallModel.h"

@protocol CategoryResultModel

@end

@interface CategoryResultModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSArray<CategoryModel, Optional> *categories;
@property (nonatomic, strong) WallModel *items;

@end
