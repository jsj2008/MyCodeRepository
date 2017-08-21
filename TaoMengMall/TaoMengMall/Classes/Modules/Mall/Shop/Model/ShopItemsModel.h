//
//  ShopItemsModel.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopItemModel.h"

@interface ShopItemsModel : BaseModel

@property (nonatomic, strong) NSString *template;
@property (nonatomic, strong) NSArray<ShopItemModel> *list;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString *wp;

@end
