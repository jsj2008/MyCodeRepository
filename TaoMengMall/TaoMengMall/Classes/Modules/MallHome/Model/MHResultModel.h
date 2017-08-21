//
//  MHResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/23.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MHModuleModel.h"
#import "ShareInfoModel.h"

@interface MHResultModel : BaseModel
@property (nonatomic, strong) NSArray <MHModuleModel>*list;
@property (nonatomic,strong) ShareInfoModel<Optional> *share;
@end
