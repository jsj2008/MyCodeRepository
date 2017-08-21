//
//  MineRequest.m
//  HongBao
//
//  Created by Ivan on 16/3/8.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "MineRequest.h"

#define MINE_REQUEST_URL                                          @"/user_me"
#define MINE_CHANGE_AVATAR_REQUEST_URL                            @"/user_me/changeavatar"
#define MINE_CHANGE_NAME_REQUEST_URL                              @"/user_me/changename"
#define MINE_CHANGE_GENDER_REQUEST_URL                            @"/user_me/changegender"
#define MINE_GET_VIP_DATA_REQUEST_URL                              @"/user_me/vip"
#define BECOME_MEMBER_REQUEST_URL                              @"/pay_vip/submit"


@implementation MineRequest

+ (void)getMineDataWithParams:(NSDictionary *)params success:(void(^)(MineResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] getWithUrl:MINE_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MineResultModel *mineResult = [[MineResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(mineResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)changeAvatarWithParams:(NSDictionary *)params image:(UIImage *)image success:(void(^)(MIChangeAvatarResultModel *resultModel))success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postImageWithUrl:MINE_CHANGE_AVATAR_REQUEST_URL image:image parameters:params progress:^(NSProgress *uploadProgress) {

    } success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        MIChangeAvatarResultModel *changeAvatarResult = [[MIChangeAvatarResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(changeAvatarResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)changeNameWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:MINE_CHANGE_NAME_REQUEST_URL parameters:params success:^(NSDictionary *result) {
      
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)changeGenderWithParams:(NSDictionary *)params success:(void(^)())success failure:(void(^)(StatusModel *status))failure {
    
    [[TTNetworkManager sharedInstance] postWithUrl:MINE_CHANGE_GENDER_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        if (success) {
            success();
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)getVipDataWithParams:(NSDictionary *)params success:(void (^)(VipResultModel *))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:MINE_GET_VIP_DATA_REQUEST_URL parameters:params success:^(NSDictionary *result) {
        
        NSError *err = [[NSError alloc] init];
        
        VipResultModel *vipResult = [[VipResultModel alloc] initWithDictionary:result error:&err];
        
        if (success) {
            success(vipResult);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
    
}

+ (void)becomeMemberWithParams:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(StatusModel *))failure
{
    [[TTNetworkManager sharedInstance] getWithUrl:BECOME_MEMBER_REQUEST_URL parameters:params success:^(NSDictionary *result) {
                
        
        
        if (success) {
            success(result);
        }
        
    } failure:^(StatusModel *status) {
        if (failure) {
            failure(status);
        }
    }];
}
@end
