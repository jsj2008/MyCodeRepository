//
//  CategoryModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol CategoryModel

@end

@interface CategoryModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageSrc;
@property (nonatomic, strong) NSString *link;

@end
