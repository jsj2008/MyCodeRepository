//
//  MCCategorySiftModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MCCategorySiftKeyModel.h"
#import "MCCategorySiftOptionModel.h"

@protocol MCCategorySiftModel <NSObject>


@end

@interface MCCategorySiftModel : BaseModel

@property (nonatomic,strong) MCCategorySiftKeyModel<Optional> *key;
@property (nonatomic,strong) NSArray<MCCategorySiftOptionModel,Optional> *options;

@end
