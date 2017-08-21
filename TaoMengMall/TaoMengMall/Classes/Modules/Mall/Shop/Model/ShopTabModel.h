//
//  ShopTabModel.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "ShopTabCateModel.h"

@protocol ShopTabModel <NSObject>

@end

@interface ShopTabModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSArray<ShopTabCateModel,Optional> *list;
@end
