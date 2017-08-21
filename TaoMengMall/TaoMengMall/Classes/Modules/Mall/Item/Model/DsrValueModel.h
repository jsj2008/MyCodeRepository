//
//  DsrValueModel.h
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol DsrValueModel

@end

@interface DsrValueModel : BaseModel

@property (nonatomic, strong) NSString *v;
@property (nonatomic, strong) NSString<Optional> *d;

@end
