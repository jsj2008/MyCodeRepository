//
//  TopUpItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol TopUpItemModel <NSObject>


@end

@interface TopUpItemModel : BaseModel
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *title;
@end
