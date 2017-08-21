//
//  CSConsigneeInfoModel.h
//  HongBao
//
//  Created by Ivan on 16/2/20.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol CSConsigneeInfoModel

@end

@interface CSConsigneeInfoModel : BaseModel

@property (nonatomic, strong) NSString *consigneeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString<Optional> *district;
@property (nonatomic, strong) NSString *address;

@end