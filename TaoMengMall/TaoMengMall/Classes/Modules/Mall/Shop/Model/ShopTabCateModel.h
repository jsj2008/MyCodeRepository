//
//  ShopTabCateModel.h
//  FlyLantern
//
//  Created by marco on 20/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"

@protocol ShopTabCateModel <NSObject>


@end

@interface ShopTabCateModel : BaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) BOOL isSelected;
@end
