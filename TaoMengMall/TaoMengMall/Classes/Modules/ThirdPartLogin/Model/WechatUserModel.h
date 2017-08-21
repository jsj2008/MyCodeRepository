//
//  WechatUserModel.h
//  BabyDaily
//
//  Created by marco on 8/23/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "BaseModel.h"

@interface WechatUserModel : BaseModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSArray<Optional> *privilege;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *unionid;
@property (nonatomic, strong) NSString<Ignore> *refresh_token;
@property (nonatomic, strong) NSString<Ignore> *access_token;


@end
