//
//  MCShopResultModel.h
//  FlyLantern
//
//  Created by 任梦晗 on 17/4/19.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "MCShopModel.h"

@protocol MCShopResultModel

@end

@interface MCShopResultModel : BaseModel

@property (nonatomic,copy) NSString<Optional> *wp;
@property (nonatomic,assign) BOOL isEnd;
@property (nonatomic,strong) NSArray<MCShopModel,Optional> *list;

@end
