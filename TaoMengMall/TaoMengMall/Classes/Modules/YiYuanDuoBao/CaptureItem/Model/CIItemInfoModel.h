//
//  CIItemInfoModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@interface CIItemInfoModel : BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) float ar;
@end
