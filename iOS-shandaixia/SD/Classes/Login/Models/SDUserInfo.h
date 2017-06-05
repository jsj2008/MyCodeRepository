//
//  SDUserInfo.h
//  YPReusableController
//
//  Created by 余艾星 on 17/2/16.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDUserInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pwd;

@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *dateBirth;
@property (nonatomic, copy) NSString *address;

@property (nonatomic, strong) UIImage *image;



@property (nonatomic, copy) NSString *headUrl;

//借款总额
@property (nonatomic, copy) NSNumber *borrowingAmountSum;

@property (nonatomic, copy) NSNumber *passSum;

@property (nonatomic, copy) NSNumber *discountSum;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)userInfoWithDict:(NSDictionary *)dict;

//上传头像
- (void)updateHeaderImage:(UIImage *)image;

#pragma mark - 获取沙盒路径
+ (NSString *)getUserInfoPath;

+ (SDUserInfo *)getUserInfo;

- (void)saveUserInfo;

@end
