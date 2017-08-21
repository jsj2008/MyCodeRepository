//
//  MCCategoryOptionModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MCCategorySiftOptionModel <NSObject>


@end

@interface MCCategorySiftOptionModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *value;
@property (nonatomic,copy) NSString<Optional> *desc;

@end
