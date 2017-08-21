//
//  QQUserModel.h
//  BabyDaily
//
//  Created by marco on 8/23/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface QQUserModel : BaseModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *is_lost;
@property (nonatomic, strong) NSString *figureurl;
@property (nonatomic, strong) NSString *is_yellow_vip;
@property (nonatomic, strong) NSString *is_yellow_year_vip;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *ret;
@property (nonatomic, strong) NSString *vip;
@property (nonatomic, strong) NSString *yellow_vip_level;

@end
