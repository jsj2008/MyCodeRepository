//
//  MHItemModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/22.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MHItemModel <NSObject>


@end

@interface MHItemModel : BaseModel
@property (nonatomic, assign) float ar;
@property (nonatomic, strong) NSString <Optional>*image;
@property (nonatomic, strong) NSString <Optional>*title;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*icon;
@property (nonatomic, strong) NSString <Optional>*count;
@property (nonatomic, strong) NSString <Optional>*link;
@end
