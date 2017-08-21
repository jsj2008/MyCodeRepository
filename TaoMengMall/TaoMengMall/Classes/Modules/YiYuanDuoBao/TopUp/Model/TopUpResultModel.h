//
//  TopUpResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "TopUpItemModel.h"

@interface TopUpResultModel : BaseModel
@property (nonatomic, strong) NSArray <TopUpItemModel>*options;
@end
