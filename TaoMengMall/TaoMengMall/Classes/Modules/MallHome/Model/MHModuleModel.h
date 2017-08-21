//
//  MHResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MHHeaderModel.h"
#import "MHBannerModel.h"
#import "MHItemModel.h"

@protocol MHModuleModel <NSObject>

@end

@interface MHModuleModel : BaseModel
@property (nonatomic, assign) int type;
@property (nonatomic, strong) MHHeaderModel <Optional>*header;
@property (nonatomic, strong) MHBannerModel <Optional>*banner;
@property (nonatomic, strong) NSArray <MHItemModel,Optional>*items;
@end
