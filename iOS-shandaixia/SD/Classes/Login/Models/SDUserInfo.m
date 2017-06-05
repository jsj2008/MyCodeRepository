//
//  SDUserInfo.m
//  YPReusableController
//
//  Created by 余艾星 on 17/2/16.
//  Copyright © 2017年 tyiti. All rights reserved.
//

#import "SDUserInfo.h"
#import "SDNetworkTool.h"
#import "AliyunOSSDemo.h"

@implementation SDUserInfo

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
    }
    
    return self;
}

+ (instancetype)userInfoWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.ID forKey:@"id"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.headUrl forKey:@"headUrl"];
    [aCoder encodeObject:self.borrowingAmountSum forKey:@"borrowingAmountSum"];
    [aCoder encodeObject:self.passSum forKey:@"passSum"];
    [aCoder encodeObject:self.discountSum forKey:@"discountSum"];
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.idCard forKey:@"idCard"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
    
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.account = [aDecoder decodeObjectForKey:@"userName"];
        self.ID = [aDecoder decodeObjectForKey:@"id"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        
        self.headUrl = [aDecoder decodeObjectForKey:@"headUrl"];
        self.borrowingAmountSum = [aDecoder decodeObjectForKey:@"borrowingAmountSum"];
        self.passSum = [aDecoder decodeObjectForKey:@"passSum"];
        self.discountSum = [aDecoder decodeObjectForKey:@"discountSum"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.idCard = [aDecoder decodeObjectForKey:@"idCard"];
        
    }
    
    return self;
}



#pragma mark - 获取沙盒路径
+ (NSString *)getUserInfoPath{
    
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userInfo.archive"];
    
}

+ (SDUserInfo *)getUserInfo{

    //解档数据
    SDUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:[SDUserInfo getUserInfoPath]];
    
    return userInfo;
  
}

- (void)saveUserInfo{

    //存储用户信息
    [NSKeyedArchiver archiveRootObject:self toFile:[SDUserInfo getUserInfoPath]];

}

- (void)updateHeaderImage:(UIImage *)image{

    NSString *name = [NSString stringWithFormat:@"head/%@.png",[NSString getTimestamp]];
    
//    [[AliyunOSSDemo sharedInstance] setupEnvironment];
    
    [[AliyunOSSDemo sharedInstance] uploadObjectAsyncWithName:name image:image];
    
}

@end






