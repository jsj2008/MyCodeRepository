//
//  PointDetailUsesModel.h
//  CarKeeper
//
//  Created by 任梦晗 on 17/3/7.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>
#import "PointDetailUsesListModel.h"

@protocol PointDetailUsesModel <NSObject>


@end

@interface PointDetailUsesModel : BaseModel

@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString<Optional> *wp;
@property (nonatomic,strong) NSArray<PointDetailUsesListModel,Optional> *list;
@end
