//
//  DsrModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "DsrValueModel.h"

@protocol DsrModel

@end

@interface DsrModel : BaseModel

@property (nonatomic, strong) DsrValueModel *ms;
@property (nonatomic, strong) DsrValueModel *zl;
@property (nonatomic, strong) DsrValueModel *jg;
@property (nonatomic, strong) DsrValueModel *qb;

@end
