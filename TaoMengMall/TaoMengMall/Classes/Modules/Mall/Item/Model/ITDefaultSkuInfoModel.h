//
//  ITDefaultSkuInfoModel.h
//  FlyLantern
//
//  Created by marco on 11/04/2017.
//  Copyright © 2017 wzningjie. All rights reserved.
//

#import "BaseModel.h"

@interface ITDefaultSkuInfoModel : BaseModel

@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, strong) NSString *price;
@end
