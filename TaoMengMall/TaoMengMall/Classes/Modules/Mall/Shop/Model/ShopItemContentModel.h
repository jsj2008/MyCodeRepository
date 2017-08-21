//
//  ShopItemContentModel.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"

@protocol ShopItemContentModel <NSObject>

@end

@interface ShopItemContentModel : BaseModel

@property (nonatomic, strong) NSString<Optional> *image;
@property (nonatomic, strong) NSArray<Optional> *images;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) CGFloat ar;
@property (nonatomic, assign) BOOL isFav;
@end
