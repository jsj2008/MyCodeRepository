//
//  ShopItemModel.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"
#import "ShopItemContentModel.h"

@protocol ShopItemModel <NSObject>

@end

@interface ShopItemModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *head;
@property (nonatomic, strong) ShopItemContentModel<Optional> *content;
@end
