//
//  ThirdPayResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/5.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"

@protocol ThirdPayResultModel

@end

@interface ThirdPayResultModel : BaseModel

@property (nonatomic, strong) NSString *sign;

@property (nonatomic, strong) NSString<Optional> *appid;
@property (nonatomic, strong) NSString<Optional> *prepayid;
@property (nonatomic, strong) NSString<Optional> *partnerid;
@property (nonatomic, strong) NSString<Optional> *package;
@property (nonatomic, strong) NSString<Optional> *noncestr;
@property (nonatomic, strong) NSString<Optional> *timestamp;
@end
