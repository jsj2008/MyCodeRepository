//
//  UserInfoResultModel.h
//  HongBao
//
//  Created by Ivan on 16/3/5.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "BDUserInfoModel.h"

@protocol LRUserInfoResultModel

@end

@interface LRUserInfoResultModel : BaseModel

@property (nonatomic, strong) BDUserInfoModel *user;
@property (nonatomic, strong) NSString<Optional> *tip;

@end
