//
//  ConsigneeModel.h
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ConsigneeModel

@end

@interface ConsigneeModel : BaseModel

@property (nonatomic, strong) NSString *consigneeId;
@property (nonatomic, strong) NSString <Optional>*province;
@property (nonatomic, strong) NSString <Optional>*city;
@property (nonatomic, strong) NSString<Optional> *district;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) BOOL isDefault;

@end
