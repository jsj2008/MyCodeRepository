//
//  CategoryResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "WallModel.h"

@protocol SearchResultModel

@end

@interface SearchResultModel : BaseModel

@property (nonatomic, strong) WallModel *items;

@end
