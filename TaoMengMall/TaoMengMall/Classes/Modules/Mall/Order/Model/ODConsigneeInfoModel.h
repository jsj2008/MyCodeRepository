//
//  ODConsigneeInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/3/7.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ODConsigneeInfoModel

@end

@interface ODConsigneeInfoModel : BaseModel

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;

@end
