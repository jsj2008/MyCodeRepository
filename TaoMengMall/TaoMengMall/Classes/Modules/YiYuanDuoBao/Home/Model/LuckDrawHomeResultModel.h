//
//  HomeResultModel.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/15.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import "LuckDrawHomeAdvertModel.h"
#import "LuckDrawHomeItemModel.h"

@interface LuckDrawHomeResultModel : BaseModel
@property (nonatomic, strong) LuckDrawHomeAdvertModel <Optional>*advert;
@property (nonatomic, strong) NSArray <LuckDrawHomeItemModel>*items;
@property (nonatomic, copy) NSString *wp;
@property (nonatomic, assign) BOOL isEnd;
@end
