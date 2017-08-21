//
//  MHHeaderModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

#import "MHHeaderBarModel.h"
#import "MHHeaderTitleModel.h"
#import "MHHeaderMoreModel.h"

@interface MHHeaderModel : BaseModel
@property (nonatomic, strong) MHHeaderBarModel <Optional>*bar;
@property (nonatomic, strong) MHHeaderTitleModel <Optional>*title;
@property (nonatomic, strong) MHHeaderMoreModel <Optional>*more;
@end
