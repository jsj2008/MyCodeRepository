//
//  MCShopItemModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol MCShopItemModel <NSObject>

@end

@interface MCShopItemModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *link;

@end
