//
//  BDUserInfoModel.h
//  BabyDaily
//
//  Created by marco on 8/23/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface BDUserInfoModel : BaseModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *avatar;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString<Optional> *gender;

@end
