//
//  LRDetailExpressModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/17.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol LRDetailExpressModel <NSObject>

@end

@interface LRDetailExpressModel : BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSArray <Optional>*buttons;
@end
