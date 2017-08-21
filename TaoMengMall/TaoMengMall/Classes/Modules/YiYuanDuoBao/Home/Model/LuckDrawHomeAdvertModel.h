//
//  DSAdvertModel.h
//  BabyDaily
//
//  Created by wzningjie on 16/9/21.
//  Copyright © 2016年 marco. All rights reserved.
//

#import "LuckDrawHomeAdvertItemModel.h"

@protocol LuckDrawHomeAdvertModel <NSObject>


@end

@interface LuckDrawHomeAdvertModel : BaseModel
@property (nonatomic, strong) NSArray <LuckDrawHomeAdvertItemModel>*list;
@property (nonatomic, assign) float ar;
@end
