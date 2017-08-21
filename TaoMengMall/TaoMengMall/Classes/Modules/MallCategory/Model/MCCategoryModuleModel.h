//
//  MCCategoryModuleModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/21.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MCCategoryModuleModel <NSObject>


@end

@interface MCCategoryModuleModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *link;
@property (nonatomic,copy) NSString<Optional> *imageSrc;
@property (nonatomic,copy) NSString<Optional> *name;

@end
