//
//  PointDetailUsesListModel.h
//  CarKeeper
//
//  Created by 任梦晗 on 17/3/7.
//  Copyright © 2017年 marco. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

@protocol PointDetailUsesListModel <NSObject>


@end

@interface PointDetailUsesListModel : BaseModel

@property (nonatomic,strong) NSString<Optional> *desc;
@property (nonatomic,strong) NSString<Optional> *time;
@property (nonatomic,strong) NSString<Optional> *amount;

@end
