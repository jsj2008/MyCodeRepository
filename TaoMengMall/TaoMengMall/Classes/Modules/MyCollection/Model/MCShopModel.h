//
//  MCShopModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MCShopItemModel.h"
@protocol MCShopModel <NSObject>


@end

@interface MCShopModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *id;
@property (nonatomic,copy) NSString<Optional> *image;
@property (nonatomic,copy) NSString<Optional> *name;
@property (nonatomic,copy) NSString<Optional> *sales;
@property (nonatomic,copy) NSString<Optional> *favCount;
@property (nonatomic,copy) NSString<Optional> *link;
@property (nonatomic,assign) int count;
@property (nonatomic,copy) NSString<Optional> *similarLink;
@property (nonatomic,strong) NSArray<MCShopItemModel,Optional> *items;

@end
