//
//  ConsigneeResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/14.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ConsigneeResultModel

@end

@interface ConsigneeResultModel : BaseModel

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceCode;

@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, strong) NSString *city;

@property (nonatomic, copy) NSString<Optional> *districtCode;
@property (nonatomic, strong) NSString<Optional> *district;

@property (nonatomic, copy) NSString<Optional> *zip;

@end
